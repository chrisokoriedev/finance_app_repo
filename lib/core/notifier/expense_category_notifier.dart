import 'package:expense_app/core/domain/categories.dart';
import 'package:expense_app/core/state/local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseCategoryNotifier extends StateNotifier<AppStateManager> {
  ExpenseCategoryNotifier(this._dataSource)
      : super(const AppStateManager.initial());

  final ExpenseCategory _dataSource;

  Future<void> addToList(String category) async {
    state = const AppStateManager.loading();
    final response = await _dataSource.addUserSubCategories(category);
    state = response.fold(
      (failure) => AppStateManager.failed(failed: failure),
      (success) => AppStateManager.success(success: success),
    );
  }

  Future<void> getList() async {
    state = const AppStateManager.loading();
    final response = await _dataSource.getUserSubCategories();
    state = response.fold(
      (failure) => AppStateManager.failed(failed: failure),
      (success) => AppStateManager.success(success: success),
    );
  }
}
