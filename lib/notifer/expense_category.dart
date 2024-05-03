import 'package:expense_app/state/local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/categories.dart';

class ExpenseCategoryNotifier extends StateNotifier<AppStateManager> {
  ExpenseCategoryNotifier(this._dataSource)
      : super(const AppStateManager.initial());

  final ExpenseCatergory _dataSource;

  Future<void> addToList(String catergory) async {
    state = const AppStateManager.loading();
    final response = await _dataSource.addUserSubCategories(catergory);
    state = response.fold(
      (response) => AppStateManager.success(success: response),
      (error) => AppStateManager.failed(failed: error),
    );
  }

  Future<void> getList() async {
    state = const AppStateManager.loading();
    final response = await _dataSource.getUserSubCategories();
    state = response.fold(
      (response) => AppStateManager.success(success: response),
      (error) => AppStateManager.failed(failed: error),
    );
  }

  ///method to delete user record on google firestore
  // Future<void> deleteUserRecord() async {
  //   state = const AppStateManager.loading();
  //   final response = await _dataSource.deleteDataStore();
  //   state = response.fold(
  //     (error) => AppStateManager.failed(failed: error),
  //     (response) => AppStateManager.success(success: response),
  //   );
  // }
}

final expenseCategoryNotifier =
    StateNotifierProvider<ExpenseCategoryNotifier, AppStateManager>(
  (ref) => ExpenseCategoryNotifier(
    ref.read(expenseCatergoryState),
  ),
);
