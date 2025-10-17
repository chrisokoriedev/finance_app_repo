import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/expense.dart';
import '../../domain/result.dart';

/// Local data source for expense operations using Hive
abstract class ExpenseLocalDataSource {
  Future<Result<List<Expense>>> getExpenses({
    ExpenseFilter? filter,
    int? limit,
  });
  
  Future<Result<Expense>> getExpenseById(String id);
  
  Future<Result<Expense>> createExpense(CreateExpenseRequest request);
  
  Future<Result<Expense>> updateExpenseById(String id, UpdateExpenseRequest request);
  
  Future<Result<void>> deleteExpense(String id);
  
  Future<Result<List<String>>> getCategories();
  
  Future<Result<String>> addCategory(String category);
  
  Future<Result<void>> cacheExpenses(List<Expense> expenses);
  
  Future<Result<void>> cacheExpense(Expense expense);
  
  Future<Result<void>> markAsPendingSync(String id);
  
  Future<Result<void>> markAsPendingDeletion(String id);
  
  Future<Result<void>> markCategoryAsPendingSync(String category);
  
  Future<Result<List<PendingSyncItem>>> getPendingSyncItems();
  
  Future<Result<void>> removePendingSync(String id);
}

/// Implementation of local data source using Hive
class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  static const String _expenseBoxName = 'expenses';
  static const String _categoryBoxName = 'categories';
  static const String _pendingSyncBoxName = 'pending_sync';

  late Box<Expense> _expenseBox;
  late Box<String> _categoryBox;
  late Box<PendingSyncItem> _pendingSyncBox;

  /// Initialize Hive boxes
  Future<void> init() async {
    _expenseBox = await Hive.openBox<Expense>(_expenseBoxName);
    _categoryBox = await Hive.openBox<String>(_categoryBoxName);
    _pendingSyncBox = await Hive.openBox<PendingSyncItem>(_pendingSyncBoxName);
  }

  @override
  Future<Result<List<Expense>>> getExpenses({
    ExpenseFilter? filter,
    int? limit,
  }) async {
    try {
      final expenses = _expenseBox.values.toList();
      
      // Apply filters
      var filteredExpenses = expenses.where((expense) {
        if (filter == null) return true;
        
        // Type filter
        if (filter.types != null && !filter.types!.contains(expense.type)) {
          return false;
        }
        
        // Category filter
        if (filter.categories != null && !filter.categories!.contains(expense.category)) {
          return false;
        }
        
        // Date range filter
        if (filter.startDate != null && expense.dateTime.isBefore(filter.startDate!)) {
          return false;
        }
        if (filter.endDate != null && expense.dateTime.isAfter(filter.endDate!)) {
          return false;
        }
        
        // Amount range filter
        if (filter.minAmount != null && expense.amount < filter.minAmount!) {
          return false;
        }
        if (filter.maxAmount != null && expense.amount > filter.maxAmount!) {
          return false;
        }
        
        // Search query filter
        if (filter.searchQuery != null && 
            !expense.name.toLowerCase().contains(filter.searchQuery!.toLowerCase()) &&
            !expense.description.toLowerCase().contains(filter.searchQuery!.toLowerCase())) {
          return false;
        }
        
        // Recurring filter
        if (filter.isRecurring != null && expense.isRecurring != filter.isRecurring!) {
          return false;
        }
        
        return true;
      }).toList();
      
      // Sort by date (newest first)
      filteredExpenses.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      
      // Apply limit
      if (limit != null && limit > 0) {
        filteredExpenses = filteredExpenses.take(limit).toList();
      }
      
      return Result.success(filteredExpenses);
    } catch (e) {
      return Result.failure('Failed to get local expenses: ${e.toString()}');
    }
  }

  @override
  Future<Result<Expense>> getExpenseById(String id) async {
    try {
      final expense = _expenseBox.get(id);
      if (expense == null) {
        return const Result.failure('Expense not found');
      }
      return Result.success(expense);
    } catch (e) {
      return Result.failure('Failed to get expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<Expense>> createExpense(CreateExpenseRequest request) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final expense = Expense(
        id: id,
        name: request.name,
        amount: request.amount,
        type: request.type,
        description: request.description,
        dateTime: request.dateTime,
        category: request.category,
        isRecurring: request.isRecurring,
        recurringPattern: request.recurringPattern,
        tags: request.tags,
        receiptUrl: request.receiptUrl,
        latitude: request.latitude,
        longitude: request.longitude,
        location: request.location,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _expenseBox.put(id, expense);
      return Result.success(expense);
    } catch (e) {
      return Result.failure('Failed to create expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<Expense>> updateExpenseById(String id, UpdateExpenseRequest request) async {
    try {
      final existingExpense = _expenseBox.get(id);
      if (existingExpense == null) {
        return const Result.failure('Expense not found');
      }
      
      final updatedExpense = existingExpense.copyWith(
        name: request.name ?? existingExpense.name,
        amount: request.amount ?? existingExpense.amount,
        type: request.type ?? existingExpense.type,
        description: request.description ?? existingExpense.description,
        dateTime: request.dateTime ?? existingExpense.dateTime,
        category: request.category ?? existingExpense.category,
        isRecurring: request.isRecurring ?? existingExpense.isRecurring,
        recurringPattern: request.recurringPattern ?? existingExpense.recurringPattern,
        tags: request.tags ?? existingExpense.tags,
        receiptUrl: request.receiptUrl ?? existingExpense.receiptUrl,
        latitude: request.latitude ?? existingExpense.latitude,
        longitude: request.longitude ?? existingExpense.longitude,
        location: request.location ?? existingExpense.location,
        updatedAt: DateTime.now(),
      );
      
      await _expenseBox.put(id, updatedExpense);
      return Result.success(updatedExpense);
    } catch (e) {
      return Result.failure('Failed to update expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> deleteExpense(String id) async {
    try {
      await _expenseBox.delete(id);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to delete expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<String>>> getCategories() async {
    try {
      final categories = _categoryBox.values.toList();
      return Result.success(categories);
    } catch (e) {
      return Result.failure('Failed to get categories: ${e.toString()}');
    }
  }

  @override
  Future<Result<String>> addCategory(String category) async {
    try {
      await _categoryBox.put(category, category);
      return Result.success(category);
    } catch (e) {
      return Result.failure('Failed to add category: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> cacheExpenses(List<Expense> expenses) async {
    try {
      final Map<String, Expense> expenseMap = {
        for (final expense in expenses) expense.id: expense
      };
      await _expenseBox.putAll(expenseMap);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to cache expenses: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> cacheExpense(Expense expense) async {
    try {
      await _expenseBox.put(expense.id, expense);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to cache expense: ${e.toString()}');
    }
  }

  Future<Result<void>> updateExpense(Expense expense) async {
    try {
      await _expenseBox.put(expense.id, expense);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to update expense: ${e.toString()}');
    }
  }

  Future<Result<void>> cacheCategories(List<String> categories) async {
    try {
      final Map<String, String> categoryMap = {
        for (final category in categories) category: category
      };
      await _categoryBox.putAll(categoryMap);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to cache categories: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> markAsPendingSync(String id) async {
    try {
      final expense = _expenseBox.get(id);
      if (expense != null) {
        final pendingItem = PendingSyncItem(
          id: id,
          expense: expense,
          isNew: false,
          isDeleted: false,
          timestamp: DateTime.now(),
        );
        await _pendingSyncBox.put(id, pendingItem);
      }
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to mark as pending sync: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> markAsPendingDeletion(String id) async {
    try {
      final expense = _expenseBox.get(id);
      if (expense != null) {
        final pendingItem = PendingSyncItem(
          id: id,
          expense: expense,
          isNew: false,
          isDeleted: true,
          timestamp: DateTime.now(),
        );
        await _pendingSyncBox.put(id, pendingItem);
      }
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to mark as pending deletion: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> markCategoryAsPendingSync(String category) async {
    try {
      // For now, we'll handle category sync differently
      // This could be extended to track category changes
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to mark category as pending sync: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<PendingSyncItem>>> getPendingSyncItems() async {
    try {
      final items = _pendingSyncBox.values.toList();
      return Result.success(items);
    } catch (e) {
      return Result.failure('Failed to get pending sync items: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> removePendingSync(String id) async {
    try {
      await _pendingSyncBox.delete(id);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Failed to remove pending sync: ${e.toString()}');
    }
  }
}

/// Model for tracking pending sync items
class PendingSyncItem {
  final String id;
  final Expense expense;
  final bool isNew;
  final bool isDeleted;
  final DateTime timestamp;

  PendingSyncItem({
    required this.id,
    required this.expense,
    required this.isNew,
    required this.isDeleted,
    required this.timestamp,
  });

  CreateExpenseRequest toCreateRequest() {
    return CreateExpenseRequest(
      name: expense.name,
      amount: expense.amount,
      type: expense.type,
      description: expense.description,
      dateTime: expense.dateTime,
      category: expense.category,
      isRecurring: expense.isRecurring,
      recurringPattern: expense.recurringPattern,
      tags: expense.tags,
      receiptUrl: expense.receiptUrl,
      latitude: expense.latitude,
      longitude: expense.longitude,
      location: expense.location,
    );
  }

  UpdateExpenseRequest toUpdateRequest() {
    return UpdateExpenseRequest(
      name: expense.name,
      amount: expense.amount,
      type: expense.type,
      description: expense.description,
      dateTime: expense.dateTime,
      category: expense.category,
      isRecurring: expense.isRecurring,
      recurringPattern: expense.recurringPattern,
      tags: expense.tags,
      receiptUrl: expense.receiptUrl,
      latitude: expense.latitude,
      longitude: expense.longitude,
      location: expense.location,
    );
  }
}
