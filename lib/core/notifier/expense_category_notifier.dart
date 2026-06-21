import 'package:expense_app/core/domain/categories.dart';
import 'package:expense_app/core/state/local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}
