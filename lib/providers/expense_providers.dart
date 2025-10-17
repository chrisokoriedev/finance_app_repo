import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/repositories/expense_repository.dart';
import '../data/local/expense_local_datasource.dart';
import '../data/remote/expense_remote_datasource.dart';
import '../domain/expense.dart';
import '../domain/result.dart';
import '../domain/enums.dart';

part 'expense_providers.g.dart';

/// Firebase Auth provider
@riverpod
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

/// Firestore provider
@riverpod
FirebaseFirestore firestore(FirestoreRef ref) {
  return FirebaseFirestore.instance;
}

/// Hive box provider for expenses
@riverpod
Future<Box<Expense>> expenseBox(ExpenseBoxRef ref) async {
  return await Hive.openBox<Expense>('expenses');
}

/// Hive box provider for categories
@riverpod
Future<Box<String>> categoryBox(CategoryBoxRef ref) async {
  return await Hive.openBox<String>('categories');
}

/// Hive box provider for pending sync
@riverpod
Future<Box<PendingSyncItem>> pendingSyncBox(PendingSyncBoxRef ref) async {
  return await Hive.openBox<PendingSyncItem>('pending_sync');
}

/// Local data source provider
@riverpod
ExpenseLocalDataSource expenseLocalDataSource(ExpenseLocalDataSourceRef ref) {
  return ExpenseLocalDataSourceImpl();
}

/// Remote data source provider
@riverpod
ExpenseRemoteDataSource expenseRemoteDataSource(
    ExpenseRemoteDataSourceRef ref) {
  return ExpenseRemoteDataSourceImpl(
    firestore: ref.watch(firestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
  );
}

/// Expense repository provider
@riverpod
ExpenseRepository expenseRepository(ExpenseRepositoryRef ref) {
  return ExpenseRepositoryImpl(
    remoteDataSource: ref.watch(expenseRemoteDataSourceProvider),
    localDataSource: ref.watch(expenseLocalDataSourceProvider),
  );
}

/// Expenses provider with filtering and pagination
@riverpod
class ExpensesNotifier extends _$ExpensesNotifier {
  @override
  Future<Result<List<Expense>>> build({
    ExpenseFilter? filter,
    int? limit,
  }) async {
    final repository = ref.watch(expenseRepositoryProvider);
    return await repository.getExpenses(
      filter: filter,
      limit: limit,
    );
  }

  /// Refresh expenses
  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  /// Load more expenses (for pagination)
  Future<void> loadMore() async {
    final currentState = await future;
    if (currentState.isSuccess) {
      final currentExpenses = currentState.data!;
      final lastExpense = currentExpenses.last;

      // This would need to be implemented with proper pagination
      // For now, we'll just refresh
      await refresh();
    }
  }

  /// Apply filter to expenses
  void applyFilter(ExpenseFilter filter) {
    ref.invalidateSelf();
  }
}

/// Single expense provider
@riverpod
class ExpenseNotifier extends _$ExpenseNotifier {
  @override
  Future<Result<Expense>> build(String id) async {
    if (id.isEmpty) return const Result.failure('Invalid expense ID');

    final repository = ref.watch(expenseRepositoryProvider);
    return await repository.getExpenseById(id);
  }

  /// Refresh expense
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// Categories provider
@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  Future<Result<List<String>>> build() async {
    final repository = ref.watch(expenseRepositoryProvider);
    return await repository.getCategories();
  }

  /// Add new category
  Future<void> addCategory(String category) async {
    final repository = ref.watch(expenseRepositoryProvider);
    final result = await repository.addCategory(category);

    if (result.isSuccess) {
      ref.invalidateSelf();
    }
  }

  /// Refresh categories
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// Expense summary provider
@riverpod
class ExpenseSummaryNotifier extends _$ExpenseSummaryNotifier {
  @override
  Future<Result<Map<String, double>>> build({
    TimePeriod? period,
    ExpenseType? type,
  }) async {
    final repository = ref.watch(expenseRepositoryProvider);
    return await repository.getExpenseSummary(
      period: period,
      type: type,
    );
  }

  /// Refresh summary
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// Expense creation provider
@riverpod
class CreateExpenseNotifier extends _$CreateExpenseNotifier {
  @override
  Future<Result<Expense>> build() async {
    return const Result.failure('No expense data');
  }

  /// Create new expense
  Future<Result<Expense>> createExpense(CreateExpenseRequest request) async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.watch(expenseRepositoryProvider);
      final result = await repository.createExpense(request);

      if (result.isSuccess) {
        state = AsyncValue.data(result);

        // Invalidate related providers
        ref.invalidate(expensesNotifierProvider);
        ref.invalidate(expenseSummaryNotifierProvider);

        return result;
      } else {
        state = AsyncValue.error(result.errorMessage!, StackTrace.current);
        return result;
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return Result.failure('Failed to create expense: ${e.toString()}');
    }
  }
}

/// Expense update provider
@riverpod
class UpdateExpenseNotifier extends _$UpdateExpenseNotifier {
  @override
  Future<Result<Expense>> build() async {
    return const Result.failure('No expense data');
  }

  /// Update expense
  Future<Result<Expense>> updateExpense(
      String id, UpdateExpenseRequest request) async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.watch(expenseRepositoryProvider);
      final result = await repository.updateExpense(id, request);

      if (result.isSuccess) {
        state = AsyncValue.data(result);

        // Invalidate related providers
        ref.invalidate(expensesNotifierProvider);
        ref.invalidate(expenseNotifierProvider(id));
        ref.invalidate(expenseSummaryNotifierProvider);

        return result;
      } else {
        state = AsyncValue.error(result.errorMessage!, StackTrace.current);
        return result;
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return Result.failure('Failed to update expense: ${e.toString()}');
    }
  }
}

/// Expense deletion provider
@riverpod
class DeleteExpenseNotifier extends _$DeleteExpenseNotifier {
  @override
  Future<Result<void>> build() async {
    return const Result.success(null);
  }

  /// Delete expense
  Future<Result<void>> deleteExpense(String id) async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.watch(expenseRepositoryProvider);
      final result = await repository.deleteExpense(id);

      if (result.isSuccess) {
        state = AsyncValue.data(result);

        // Invalidate related providers
        ref.invalidate(expensesNotifierProvider);
        ref.invalidate(expenseNotifierProvider(id));
        ref.invalidate(expenseSummaryNotifierProvider);

        return result;
      } else {
        state = AsyncValue.error(result.errorMessage!, StackTrace.current);
        return result;
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return Result.failure('Failed to delete expense: ${e.toString()}');
    }
  }
}

/// Sync provider for offline/online synchronization
@riverpod
class SyncNotifier extends _$SyncNotifier {
  @override
  Future<Result<void>> build() async {
    return const Result.success(null);
  }

  /// Sync expenses with remote
  Future<Result<void>> syncExpenses() async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.watch(expenseRepositoryProvider);
      final result = await repository.syncExpenses();

      if (result.isSuccess) {
        state = AsyncValue.data(result);

        // Invalidate all expense-related providers
        ref.invalidate(expensesNotifierProvider);
        ref.invalidate(categoriesNotifierProvider);
        ref.invalidate(expenseSummaryNotifierProvider);

        return result;
      } else {
        state = AsyncValue.error(result.errorMessage!, StackTrace.current);
        return result;
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return Result.failure('Failed to sync expenses: ${e.toString()}');
    }
  }
}

/// Filter state provider
@riverpod
class ExpenseFilterNotifier extends _$ExpenseFilterNotifier {
  @override
  ExpenseFilter build() {
    return const ExpenseFilter();
  }

  /// Update filter
  void updateFilter(ExpenseFilter filter) {
    state = filter;
    ref.invalidate(expensesNotifierProvider);
  }

  /// Clear filter
  void clearFilter() {
    state = const ExpenseFilter();
    ref.invalidate(expensesNotifierProvider);
  }

  /// Set time period filter
  void setTimePeriod(TimePeriod period) {
    final (start, end) = period.dateRange;
    state = state.copyWith(
      startDate: start,
      endDate: end,
    );
    ref.invalidate(expensesNotifierProvider);
  }

  /// Set expense type filter
  void setExpenseType(ExpenseType type) {
    state = state.copyWith(types: [type]);
    ref.invalidate(expensesNotifierProvider);
  }

  /// Set search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query.isEmpty ? null : query);
    ref.invalidate(expensesNotifierProvider);
  }
}
