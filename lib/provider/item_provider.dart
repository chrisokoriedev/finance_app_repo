// import 'package:expense_app/model/cal_model.dart';
// import 'package:expense_app/model/create_expense.dart';
// import 'package:expense_app/state/local.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive/hive.dart';

import 'package:expense_app/model/create_expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final itemBoxProvider = FutureProvider<Box<CreateExpenseModel>>(
  (ref) => Hive.openBox<CreateExpenseModel>("data"),
);

// class TotalNotifierProvider extends StateNotifier<AppStateManager> {
//   final TotalNotifier _bioAuth;
//   TotalNotifierProvider(this._bioAuth) : super(const AppStateManager.initial());

//   Future loginBioWithLocalAuth() async {
//     state = const AppStateManager.loading();
//     final response = await _bioAuth.calculateTotals();
//     state = response.fold(
//       (failed) => const AppStateManager.failed(failed: ''),
//       (response) => const AppStateManager.success(success: ''),
//     );
//   }
// }

// final totalNotifierProvider =
//     StateNotifierProvider<TotalNotifierProvider, AppStateManager>(
//   (ref) => TotalNotifierProvider(ref.read(totalProvider)),
// );

final itemsProvider = FutureProvider<List<CreateExpenseModel>>((ref) async {
  final box = await ref.watch(itemBoxProvider.future);
  return box.values.toList();
});
