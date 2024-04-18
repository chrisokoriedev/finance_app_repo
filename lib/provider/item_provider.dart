import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final itemBoxProvider =
    FutureProvider((ref) => Hive.openBox<CreateExpenseModel>(AppString.hiveDb));

final cloudItemsProvider = FutureProvider((ref) async {
  final fireAuth =
      ref.watch(firebaseAuthProvider.select((value) => value.currentUser!.uid));
  final fireStore = ref.watch(fireStoreProvider);
  final QuerySnapshot querySnapshot = await fireStore
      .collection(AppString.expense)
      .doc(fireAuth)
      .collection(AppString.userExpense)
      .get();

  List<CreateExpenseModel> expenseList = [];
  for (var doc in querySnapshot.docs) {
    final data = doc.data() as Map<String, dynamic>; // Explicit cast
    if (data.containsKey('expenseType')) {
      expenseList.add(CreateExpenseModel.fromJson(data));
    }
  }
  return expenseList.toList()..sort((a, b) => b.dateTime.compareTo(a.dateTime));
});

// final cloudItemsProvider = FutureProvider<List<CreateExpenseModel>>((ref) async {
//   final box = await ref.watch(itemBoxProvider.future);
//   return box.values.toList()..sort((a, b) => b.dateTime.compareTo(a.dateTime));
// });
