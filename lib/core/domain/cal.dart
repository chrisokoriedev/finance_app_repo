// ignore_for_file: unused_result, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/provider/firebase.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Totals {
  final double totalExpense;
  final double totalIncome;
  final double totalDebt;

  const Totals(this.totalExpense, this.totalIncome, this.totalDebt);

  double get grandTotal => totalIncome - (totalExpense + totalDebt);
}

/// Reactive totals derived directly from [cloudItemsProvider]. Recomputes
/// automatically whenever the expense list changes, so there is no separate
/// notifier to keep in sync and no manual `calculateTotals` call from the UI.
final totalsProvider = Provider.autoDispose<Totals>((ref) {
  final itemsAsync = ref.watch(cloudItemsProvider);
  return itemsAsync.maybeWhen(
    data: (expenses) {
      double income = 0;
      double expense = 0;
      double debt = 0;
      for (final item in expenses) {
        switch (item.expenseType) {
          case 'Income':
            income += item.amount;
          case 'Expense':
            expense += item.amount;
          case 'Debt':
            debt += item.amount;
        }
      }
      return Totals(expense, income, debt);
    },
    orElse: () => const Totals(0, 0, 0),
  );
});

final addExpenseProvider = StateProvider((ref) => AddExpenseNotifer(
    ref, ref.read(firebaseAuthProvider), ref.read(fireStoreProvider)));

class AddExpenseNotifer {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final Ref ref;
  AddExpenseNotifer(this.ref, this._firebaseAuth, this._firebaseFirestore);
  Future<Either<String, dynamic>> addExpense(CreateExpenseModel expense) async {
    try {
      final firestoreInstance = _firebaseFirestore;
      final userId = _firebaseAuth.currentUser!.uid;
      if (userId.isNotEmpty) {
        await firestoreInstance
            .collection(AppString.expense)
            .doc(userId)
            .collection(AppString.userExpense)
            .add({
          'name': expense.name,
          'amount': expense.amount,
          'expenseType': expense.expenseType,
          'explain': expense.explain,
          'dateTime': expense.dateTime.toIso8601String(),
          'expenseSubList': expense.expenseSubList,
        });
      }
      ref.refresh(cloudItemsProvider);
      return right('Expense Added');
    } catch (e) {
      debugPrint(e.toString());
      return left(e.toString());
    }
  }

  Future<Either<String, dynamic>> deleteDataStore() async {
    final firestoreInstance = _firebaseFirestore;
    try {
      if (_firebaseAuth.currentUser != null) {
        await firestoreInstance
            .collection(AppString.expense)
            .doc(_firebaseAuth.currentUser!.uid)
            .collection(AppString.userExpense)
            .get()
            .then((snapshot) {
          for (DocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        });
      }
      ref.refresh(cloudItemsProvider.future);
      return right('Data store deleted successfully');
    } catch (e) {
      debugPrint(e.toString());
      return left(e.toString());
    }
  }
}

final deleteExpenseProvider = StateProvider((ref) => DeleteExpense(
    ref, ref.read(firebaseAuthProvider), ref.read(fireStoreProvider)));

class DeleteExpense {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final Ref ref;

  DeleteExpense(this.ref, this._firebaseAuth, this._firebaseFirestore);

  /// Deletes a single expense by its Firestore [documentId]. Deleting by id
  /// (rather than matching on the name) guarantees the exact record the user
  /// swiped is removed, even when multiple records share the same name.
  Future<void> deleteExpense(String documentId) async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return;

    try {
      await _firebaseFirestore
          .collection(AppString.expense)
          .doc(userId)
          .collection(AppString.userExpense)
          .doc(documentId)
          .delete();
      ref.refresh(cloudItemsProvider.future);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
