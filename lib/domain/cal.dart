// ignore_for_file: unused_result, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalStateProvider = StateProvider((ref) => TotalNotifier());
final totalProvider = StateProvider<Totals>((ref) => const Totals(0, 0, 0));

class Totals {
  final double totalExpense;
  final double totalIncome;
  final double totalDebt;

  const Totals(this.totalExpense, this.totalIncome, this.totalDebt);

  double get grandTotal => totalIncome - (totalExpense + totalDebt);
}

class TotalNotifier extends StateNotifier<Totals> {
  TotalNotifier() : super(const Totals(0, 0, 0));

  void calculateTotals(List<CreateExpenseModel> expenses) {
    double totalExpense = 0;
    double totalIncome = 0;
    double totalDebt = 0;

    for (var expense in expenses) {
      double amount = expense.amount;
      if (expense.expenseType == 'Income') {
        totalIncome += amount;
      } else if (expense.expenseType == 'Expense') {
        totalExpense += amount;
      } else if (expense.expenseType == 'Debt') {
        totalDebt += amount;
      }
    }
    state = Totals(totalExpense, totalIncome, totalDebt);
  }
}

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
      ref.refresh(totalStateProvider);
      ref.refresh(cloudItemsProvider);
      return left('Expense Added');
    } catch (e) {
      debugPrint(e.toString());
      return right(e);
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
      ref.refresh(totalStateProvider.notifier).state;
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

  Future<void> deleteExpense(var expenseName) async {
    final firestoreInstance = _firebaseFirestore;
    final userId = _firebaseAuth.currentUser!.uid;

    try {
      QuerySnapshot querySnapshot = await firestoreInstance
          .collection(AppString.expense)
          .doc(userId)
          .collection(AppString.userExpense)
          .where('name', isEqualTo: expenseName)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs.first.id;
        await firestoreInstance
            .collection(AppString.expense)
            .doc(userId)
            .collection(AppString.userExpense)
            .doc(documentId)
            .delete();
        ref.refresh(totalStateProvider.notifier).state;
        ref.refresh(cloudItemsProvider.future);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }


}
