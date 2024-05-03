import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
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
  return expenseList.toList();
});
final expenseListCatProvider = FutureProvider((ref) async {
  final fireAuth =
      ref.watch(firebaseAuthProvider.select((value) => value.currentUser!.uid));
  final fireStore = ref.watch(fireStoreProvider);
  final QuerySnapshot querySnapshot = await fireStore
      .collection(AppString.expenseSubList)
      .doc(fireAuth)
      .collection(AppString.expenseSubList)
      .get();
  List<String> categories = [];
  for (var doc in querySnapshot.docs) {
    final data = doc.data() as Map<String, dynamic>;
    if (data.containsKey(AppString.expenseSubList)) {
      categories.add(data[AppString.expenseSubList]);
    }
  }

  return categories;
});

final imageProvider = FutureProvider<String>((ref) async {
  final remoteConfig = ref.watch(remoteConfigProvider);
  try {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 10)));
    await remoteConfig.fetchAndActivate();
    return remoteConfig.getString('auth_image');
  } on FirebaseException catch (e) {
    debugPrint(e.toString());
    return e.toString();
  }
});
