import 'package:expense_app/domain/cal.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/state/local.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateExpenseNotifier extends StateNotifier<AppStateManager> {
  CreateExpenseNotifier(this._dataSource)
      : super(const AppStateManager.initial());

  final AddExpenseNotifer _dataSource;

  Future<void> addExpense(CreateExpenseModel add) async {
    state = const AppStateManager.loading();
    final response = await _dataSource.addExpense(add);
    state = response.fold(
      (error) => AppStateManager.failed(failed: error),
      (response) => AppStateManager.success(success: response),
    );
  }
}

final createExpenseNotifierProvider =
    StateNotifierProvider<CreateExpenseNotifier, AppStateManager>(
  (ref) => CreateExpenseNotifier(
    ref.read(addExpenseProvider),
  ),
);
