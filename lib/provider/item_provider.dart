import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final cloudItemsProvider = FutureProvider((ref) async {
//   final fireAuth =
//       ref.watch(firebaseAuthProvider.select((value) => value.currentUser!.uid));
//   final fireStore = ref.watch(fireStoreProvider);
//   final QuerySnapshot querySnapshot = await fireStore
//       .collection(AppString.expense)
//       .doc(fireAuth)
//       .collection(AppString.userExpense)
//       .get();
//   List<CreateExpenseModel> expenseList = [];
//   for (var doc in querySnapshot.docs) {
//     final data = doc.data() as Map<String, dynamic>;
//     if (data.containsKey('expenseType')) {
//       expenseList.add(CreateExpenseModel.fromJson(data));
//     }
//   }
//   return expenseList.toList()..sort((a, b) => b.dateTime.compareTo(a.dateTime));
// });


final cloudItemsProvider =
    FutureProvider<List<CreateExpenseModel>>((ref) async {
  final fireAuth =
      ref.watch(firebaseAuthProvider.select((value) => value.currentUser!.uid));
  final fireStore = ref.watch(fireStoreProvider);

  final cacheManager = DefaultCacheManager();

  FileInfo? fileInfo;
  try {
    fileInfo = await cacheManager.getFileFromCache(AppString.userExpense);
  } catch (e) {
    debugPrint('Error checking cache: $e');
  }

  if (fileInfo != null && fileInfo.validTill.isAfter(DateTime.now())) {
    try {
      final cachedData =
          await cacheManager.getFileFromCache(AppString.userExpense);
      final expenseList = List<CreateExpenseModel>.from(
          jsonDecode(cachedData as String)
              .map((x) => CreateExpenseModel.fromJson(x)));
      return expenseList.toList()
        ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
    } catch (e) {
      debugPrint('Error reading cached data: $e');
    }
  }

  try {
    final querySnapshot = await fireStore
        .collection(AppString.expense)
        .doc(fireAuth)
        .collection(AppString.userExpense)
        .get();
    List<CreateExpenseModel> expenseList = [];
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      if (data.containsKey('expenseType')) {
        expenseList.add(CreateExpenseModel.fromJson(data));
      }
    }

    await cacheManager.putFile(
        AppString.userExpense, utf8.encode(jsonEncode(expenseList)));

    return expenseList.toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  } catch (e) {
    debugPrint('Error fetching data from Firestore: $e');
    return []; 
  }
});
