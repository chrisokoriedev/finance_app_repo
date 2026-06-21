import 'package:expense_app/core/domain/cal.dart';
import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/state/local.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateExpenseNotifier extends StateNotifier<AppStateManager> {
  CreateExpenseNotifier(this._dataSource)
      : super(const AppStateManager.initial());

  final AddExpenseNotifer _dataSource;

  Future<void> addExpense(CreateExpenseModel add) async {
    state = const AppStateManager.loading();
    final response = await _dataSource.addExpense(add);
    state = response.fold(
      (failure) => AppStateManager.failed(failed: failure),
      (success) => AppStateManager.success(success: success),
    );
  }

  ///method to delete user record on google firestore
  Future<void> deleteUserRecord() async {
    state = const AppStateManager.loading();
    final response = await _dataSource.deleteDataStore();
    state = response.fold(
      (error) => AppStateManager.failed(failed: error),
      (response) => AppStateManager.success(success: response),
    );
  }
}
