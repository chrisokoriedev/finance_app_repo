import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final data = doc.data() as Map<String, dynamic>;
    if (data.containsKey('expenseType')) {
      expenseList.add(CreateExpenseModel.fromJson(data));
    }
  }
  return expenseList.toList()..sort((a, b) => b.dateTime.compareTo(a.dateTime));
});
