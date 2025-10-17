import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/expense.dart';
import '../../domain/result.dart';
import '../../domain/enums.dart';
import '../local/expense_local_datasource.dart';
import '../remote/expense_remote_datasource.dart';

/// Repository interface for expense operations
abstract class ExpenseRepository {
  Future<Result<List<Expense>>> getExpenses({
    ExpenseFilter? filter,
    int? limit,
    DocumentSnapshot? startAfter,
  });
  
  Future<Result<Expense>> getExpenseById(String id);
  
  Future<Result<Expense>> createExpense(CreateExpenseRequest request);
  
  Future<Result<Expense>> updateExpense(String id, UpdateExpenseRequest request);
  
  Future<Result<void>> deleteExpense(String id);
  
  Future<Result<List<String>>> getCategories();
  
  Future<Result<String>> addCategory(String category);
  
  Future<Result<Map<String, double>>> getExpenseSummary({
    TimePeriod? period,
    ExpenseType? type,
  });
  
  Future<Result<void>> syncExpenses();
}

/// Implementation of expense repository with offline-first approach
class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource _remoteDataSource;
  final ExpenseLocalDataSource _localDataSource;
  final FirebaseAuth _auth;

  ExpenseRepositoryImpl({
    required ExpenseRemoteDataSource remoteDataSource,
    required ExpenseLocalDataSource localDataSource,
    required FirebaseAuth auth,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _auth = auth;

  @override
  Future<Result<List<Expense>>> getExpenses({
    ExpenseFilter? filter,
    int? limit,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      // Try to get from local storage first (offline-first)
      final localResult = await _localDataSource.getExpenses(
        filter: filter,
        limit: limit,
      );

      // If we have local data, return it immediately
      if (localResult.isSuccess && localResult.data?.isNotEmpty == true) {
        // Try to sync in background
        _syncExpensesInBackground();
        return localResult;
      }

      // If no local data, try remote
      final remoteResult = await _remoteDataSource.getExpenses(
        filter: filter,
        limit: limit,
        startAfter: startAfter,
      );

      if (remoteResult.isSuccess) {
        // Cache the remote data locally
        await _localDataSource.cacheExpenses(remoteResult.data!);
        return remoteResult;
      }

      return remoteResult;
    } catch (e) {
      return Result.failure('Failed to get expenses: ${e.toString()}');
    }
  }

  @override
  Future<Result<Expense>> getExpenseById(String id) async {
    try {
      // Try local first
      final localResult = await _localDataSource.getExpenseById(id);
      if (localResult.isSuccess) {
        return localResult;
      }

      // Try remote
      final remoteResult = await _remoteDataSource.getExpenseById(id);
      if (remoteResult.isSuccess) {
        // Cache locally
        await _localDataSource.cacheExpense(remoteResult.data!);
        return remoteResult;
      }

      return remoteResult;
    } catch (e) {
      return Result.failure('Failed to get expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<Expense>> createExpense(CreateExpenseRequest request) async {
    try {
      // Create locally first for immediate feedback
      final localResult = await _localDataSource.createExpense(request);
      if (localResult.isFailure) {
        return localResult;
      }

      // Try to sync with remote
      final remoteResult = await _remoteDataSource.createExpense(request);
      if (remoteResult.isSuccess) {
        // Update local with remote data (includes ID)
        await _localDataSource.updateExpense(remoteResult.data!);
        return remoteResult;
      } else {
        // Mark as pending sync
        await _localDataSource.markAsPendingSync(localResult.data!.id);
        return localResult;
      }
    } catch (e) {
      return Result.failure('Failed to create expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<Expense>> updateExpense(String id, UpdateExpenseRequest request) async {
    try {
      // Update locally first
      final localResult = await _localDataSource.updateExpenseById(id, request);
      if (localResult.isFailure) {
        return localResult;
      }

      // Try to sync with remote
      final remoteResult = await _remoteDataSource.updateExpense(id, request);
      if (remoteResult.isSuccess) {
        await _localDataSource.updateExpense(remoteResult.data!);
        return remoteResult;
      } else {
        // Mark as pending sync
        await _localDataSource.markAsPendingSync(id);
        return localResult;
      }
    } catch (e) {
      return Result.failure('Failed to update expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> deleteExpense(String id) async {
    try {
      // Delete locally first
      final localResult = await _localDataSource.deleteExpense(id);
      if (localResult.isFailure) {
        return localResult;
      }

      // Try to sync with remote
      final remoteResult = await _remoteDataSource.deleteExpense(id);
      if (remoteResult.isFailure) {
        // Mark as pending deletion
        await _localDataSource.markAsPendingDeletion(id);
      }

      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to delete expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<String>>> getCategories() async {
    try {
      // Try local first
      final localResult = await _localDataSource.getCategories();
      if (localResult.isSuccess && localResult.data?.isNotEmpty == true) {
        return localResult;
      }

      // Try remote
      final remoteResult = await _remoteDataSource.getCategories();
      if (remoteResult.isSuccess) {
        await _localDataSource.cacheCategories(remoteResult.data!);
        return remoteResult;
      }

      return remoteResult;
    } catch (e) {
      return Result.failure('Failed to get categories: ${e.toString()}');
    }
  }

  @override
  Future<Result<String>> addCategory(String category) async {
    try {
      // Add locally first
      final localResult = await _localDataSource.addCategory(category);
      if (localResult.isFailure) {
        return localResult;
      }

      // Try to sync with remote
      final remoteResult = await _remoteDataSource.addCategory(category);
      if (remoteResult.isFailure) {
        // Mark as pending sync
        await _localDataSource.markCategoryAsPendingSync(category);
      }

      return Result.success(category);
    } catch (e) {
      return Result.failure('Failed to add category: ${e.toString()}');
    }
  }

  @override
  Future<Result<Map<String, double>>> getExpenseSummary({
    TimePeriod? period,
    ExpenseType? type,
  }) async {
    try {
      final expensesResult = await getExpenses(
        filter: ExpenseFilter(
          types: type != null ? [type] : null,
          startDate: period?.dateRange.$1,
          endDate: period?.dateRange.$2,
        ),
      );

      if (expensesResult.isFailure) {
        return Result.failure(expensesResult.errorMessage!);
      }

      final expenses = expensesResult.data!;
      final summary = <String, double>{};

      for (final expense in expenses) {
        final key = expense.type.displayName;
        summary[key] = (summary[key] ?? 0) + expense.amount;
      }

      return Result.success(summary);
    } catch (e) {
      return Result.failure('Failed to get expense summary: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> syncExpenses() async {
    try {
      // Get pending sync items
      final pendingItemsResult = await _localDataSource.getPendingSyncItems();
      
      if (pendingItemsResult.isFailure) {
        return Result.failure(pendingItemsResult.errorMessage!);
      }
      
      final pendingItems = pendingItemsResult.data!;
      
      for (final item in pendingItems) {
        if (item.isDeleted) {
          await _remoteDataSource.deleteExpense(item.id);
        } else if (item.isNew) {
          await _remoteDataSource.createExpense(item.toCreateRequest());
        } else {
          await _remoteDataSource.updateExpense(item.id, item.toUpdateRequest());
        }
        
        // Remove from pending
        await _localDataSource.removePendingSync(item.id);
      }

      // Refresh local data from remote
      final remoteExpenses = await _remoteDataSource.getExpenses();
      if (remoteExpenses.isSuccess) {
        await _localDataSource.cacheExpenses(remoteExpenses.data!);
      }

      return Result.success(null);
    } catch (e) {
      return Result.failure('Failed to sync expenses: ${e.toString()}');
    }
  }

  /// Sync expenses in background without blocking UI
  void _syncExpensesInBackground() {
    Future.microtask(() async {
      try {
        await syncExpenses();
      } catch (e) {
        // Log error but don't throw
        print('Background sync failed: $e');
      }
    });
  }
}
