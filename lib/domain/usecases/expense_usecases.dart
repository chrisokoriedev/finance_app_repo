import '../expense.dart';
import '../result.dart';
import '../enums.dart';
import '../../data/repositories/expense_repository.dart';

/// Use case for getting expenses with filtering
class GetExpensesUseCase {
  final ExpenseRepository _repository;

  GetExpensesUseCase(this._repository);

  Future<Result<List<Expense>>> call({
    ExpenseFilter? filter,
    int? limit,
  }) async {
    return await _repository.getExpenses(
      filter: filter,
      limit: limit,
    );
  }
}

/// Use case for getting expenses by time period
class GetExpensesByPeriodUseCase {
  final ExpenseRepository _repository;

  GetExpensesByPeriodUseCase(this._repository);

  Future<Result<List<Expense>>> call(TimePeriod period) async {
    final filter = ExpenseFilter.forPeriod(period);
    return await _repository.getExpenses(filter: filter);
  }
}

/// Use case for getting expenses by type
class GetExpensesByTypeUseCase {
  final ExpenseRepository _repository;

  GetExpensesByTypeUseCase(this._repository);

  Future<Result<List<Expense>>> call(ExpenseType type) async {
    final filter = ExpenseFilter.forType(type);
    return await _repository.getExpenses(filter: filter);
  }
}

/// Use case for creating expense
class CreateExpenseUseCase {
  final ExpenseRepository _repository;

  CreateExpenseUseCase(this._repository);

  Future<Result<Expense>> call(CreateExpenseRequest request) async {
    // Validate request
    final validationResult = _validateCreateRequest(request);
    if (validationResult.isFailure) {
      return Result.failure(validationResult.errorMessage!);
    }

    return await _repository.createExpense(request);
  }

  Result<void> _validateCreateRequest(CreateExpenseRequest request) {
    if (request.name.trim().isEmpty) {
      return const Result.failure('Expense name cannot be empty');
    }
    
    if (request.amount <= 0) {
      return const Result.failure('Expense amount must be greater than 0');
    }
    
    if (request.description.trim().isEmpty) {
      return const Result.failure('Expense description cannot be empty');
    }
    
    if (request.category.trim().isEmpty) {
      return const Result.failure('Expense category cannot be empty');
    }
    
    if (request.dateTime.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      return const Result.failure('Expense date cannot be in the future');
    }
    
    return const Result.success(null);
  }
}

/// Use case for updating expense
class UpdateExpenseUseCase {
  final ExpenseRepository _repository;

  UpdateExpenseUseCase(this._repository);

  Future<Result<Expense>> call(String id, UpdateExpenseRequest request) async {
    // Validate request
    final validationResult = _validateUpdateRequest(request);
    if (validationResult.isFailure) {
      return Result.failure(validationResult.errorMessage!);
    }

    return await _repository.updateExpense(id, request);
  }

  Result<void> _validateUpdateRequest(UpdateExpenseRequest request) {
    if (request.name != null && request.name!.trim().isEmpty) {
      return const Result.failure('Expense name cannot be empty');
    }
    
    if (request.amount != null && request.amount! <= 0) {
      return const Result.failure('Expense amount must be greater than 0');
    }
    
    if (request.description != null && request.description!.trim().isEmpty) {
      return const Result.failure('Expense description cannot be empty');
    }
    
    if (request.category != null && request.category!.trim().isEmpty) {
      return const Result.failure('Expense category cannot be empty');
    }
    
    if (request.dateTime != null && 
        request.dateTime!.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      return const Result.failure('Expense date cannot be in the future');
    }
    
    return const Result.success(null);
  }
}

/// Use case for deleting expense
class DeleteExpenseUseCase {
  final ExpenseRepository _repository;

  DeleteExpenseUseCase(this._repository);

  Future<Result<void>> call(String id) async {
    if (id.trim().isEmpty) {
      return const Result.failure('Expense ID cannot be empty');
    }

    return await _repository.deleteExpense(id);
  }
}

/// Use case for getting expense summary
class GetExpenseSummaryUseCase {
  final ExpenseRepository _repository;

  GetExpenseSummaryUseCase(this._repository);

  Future<Result<Map<String, double>>> call({
    TimePeriod? period,
    ExpenseType? type,
  }) async {
    return await _repository.getExpenseSummary(
      period: period,
      type: type,
    );
  }
}

/// Use case for getting categories
class GetCategoriesUseCase {
  final ExpenseRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<Result<List<String>>> call() async {
    return await _repository.getCategories();
  }
}

/// Use case for adding category
class AddCategoryUseCase {
  final ExpenseRepository _repository;

  AddCategoryUseCase(this._repository);

  Future<Result<String>> call(String category) async {
    // Validate category
    if (category.trim().isEmpty) {
      return const Result.failure('Category name cannot be empty');
    }
    
    if (category.trim().length < 2) {
      return const Result.failure('Category name must be at least 2 characters');
    }
    
    if (category.trim().length > 20) {
      return const Result.failure('Category name must be less than 20 characters');
    }

    return await _repository.addCategory(category.trim());
  }
}

/// Use case for syncing expenses
class SyncExpensesUseCase {
  final ExpenseRepository _repository;

  SyncExpensesUseCase(this._repository);

  Future<Result<void>> call() async {
    return await _repository.syncExpenses();
  }
}

/// Use case for getting expense statistics
class GetExpenseStatisticsUseCase {
  final ExpenseRepository _repository;

  GetExpenseStatisticsUseCase(this._repository);

  Future<Result<ExpenseStatistics>> call({
    TimePeriod? period,
  }) async {
    // Get all expenses for the period
    final expensesResult = await _repository.getExpenses(
      filter: period != null ? ExpenseFilter.forPeriod(period) : null,
    );

    if (expensesResult.isFailure) {
      return Result.failure(expensesResult.errorMessage!);
    }

    final expenses = expensesResult.data!;
    
    // Calculate statistics
    final statistics = _calculateStatistics(expenses);
    
    return Result.success(statistics);
  }

  ExpenseStatistics _calculateStatistics(List<Expense> expenses) {
    double totalIncome = 0;
    double totalExpense = 0;
    double totalDebt = 0;
    int incomeCount = 0;
    int expenseCount = 0;
    int debtCount = 0;
    
    final categoryTotals = <String, double>{};
    final monthlyTotals = <String, double>{};
    
    for (final expense in expenses) {
      switch (expense.type) {
        case ExpenseType.income:
          totalIncome += expense.amount;
          incomeCount++;
          break;
        case ExpenseType.expense:
          totalExpense += expense.amount;
          expenseCount++;
          break;
        case ExpenseType.debt:
          totalDebt += expense.amount;
          debtCount++;
          break;
      }
      
      // Category totals
      categoryTotals[expense.category] = 
          (categoryTotals[expense.category] ?? 0) + expense.amount;
      
      // Monthly totals
      final monthKey = '${expense.dateTime.year}-${expense.dateTime.month}';
      monthlyTotals[monthKey] = 
          (monthlyTotals[monthKey] ?? 0) + expense.signedAmount;
    }
    
    final netWorth = totalIncome - totalExpense - totalDebt;
    
    return ExpenseStatistics(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      totalDebt: totalDebt,
      netWorth: netWorth,
      incomeCount: incomeCount,
      expenseCount: expenseCount,
      debtCount: debtCount,
      categoryTotals: categoryTotals,
      monthlyTotals: monthlyTotals,
      averageIncome: incomeCount > 0 ? totalIncome / incomeCount : 0,
      averageExpense: expenseCount > 0 ? totalExpense / expenseCount : 0,
      averageDebt: debtCount > 0 ? totalDebt / debtCount : 0,
    );
  }
}

/// Expense statistics model
class ExpenseStatistics {
  final double totalIncome;
  final double totalExpense;
  final double totalDebt;
  final double netWorth;
  final int incomeCount;
  final int expenseCount;
  final int debtCount;
  final Map<String, double> categoryTotals;
  final Map<String, double> monthlyTotals;
  final double averageIncome;
  final double averageExpense;
  final double averageDebt;

  const ExpenseStatistics({
    required this.totalIncome,
    required this.totalExpense,
    required this.totalDebt,
    required this.netWorth,
    required this.incomeCount,
    required this.expenseCount,
    required this.debtCount,
    required this.categoryTotals,
    required this.monthlyTotals,
    required this.averageIncome,
    required this.averageExpense,
    required this.averageDebt,
  });

  /// Get formatted total income
  String get formattedTotalIncome => '₦${totalIncome.toStringAsFixed(2)}';
  
  /// Get formatted total expense
  String get formattedTotalExpense => '₦${totalExpense.toStringAsFixed(2)}';
  
  /// Get formatted total debt
  String get formattedTotalDebt => '₦${totalDebt.toStringAsFixed(2)}';
  
  /// Get formatted net worth
  String get formattedNetWorth => '₦${netWorth.toStringAsFixed(2)}';
  
  /// Get top category by amount
  String? get topCategory {
    if (categoryTotals.isEmpty) return null;
    
    return categoryTotals.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
  
  /// Get expense ratio (expenses / income)
  double get expenseRatio {
    if (totalIncome == 0) return 0;
    return totalExpense / totalIncome;
  }
  
  /// Get debt ratio (debt / income)
  double get debtRatio {
    if (totalIncome == 0) return 0;
    return totalDebt / totalIncome;
  }
}
