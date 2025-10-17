import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'enums.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

/// Modern expense model with better validation and methods
@freezed
class Expense with _$Expense {
  const factory Expense({
    required String id,
    required String name,
    required double amount,
    required ExpenseType type,
    required String description,
    required DateTime dateTime,
    required String category,
    String? userId,
    @Default(false) bool isRecurring,
    String? recurringPattern,
    String? tags,
    String? receiptUrl,
    @Default(0) double latitude,
    @Default(0) double longitude,
    String? location,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);
}

/// Extension methods for Expense
extension ExpenseExtension on Expense {
  /// Get formatted amount with currency
  String get formattedAmount => '₦${amount.toStringAsFixed(2)}';

  /// Get formatted date
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(dateTime).inDays;
    
    return switch (difference) {
      0 => 'Today',
      1 => 'Yesterday',
      _ when difference < 7 => '$difference days ago',
      _ when difference < 30 => '${(difference / 7).floor()} weeks ago',
      _ when difference < 365 => '${(difference / 30).floor()} months ago',
      _ => '${(difference / 365).floor()} years ago',
    };
  }

  /// Check if expense is recent (within last 7 days)
  bool get isRecent => DateTime.now().difference(dateTime).inDays <= 7;

  /// Get expense type color
  Color get typeColor => type.color;

  /// Get expense type emoji
  String get typeEmoji => type.emoji;

  /// Check if expense is positive (income)
  bool get isPositive => type.isPositive;

  /// Check if expense is negative (expense or debt)
  bool get isNegative => type.isNegative;

  /// Get signed amount (positive for income, negative for expenses/debt)
  double get signedAmount => amount * type.multiplier;

  /// Create a copy with updated fields
  Expense copyWithAmount(double newAmount) => copyWith(amount: newAmount);
  
  Expense copyWithCategory(String newCategory) => copyWith(category: newCategory);
  
  Expense copyWithType(ExpenseType newType) => copyWith(type: newType);
}

/// Custom converter for Firestore Timestamps
class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) => timestamp?.toDate();

  @override
  Timestamp? toJson(DateTime? date) => 
      date != null ? Timestamp.fromDate(date) : null;
}

/// Expense creation request model
@freezed
class CreateExpenseRequest with _$CreateExpenseRequest {
  const factory CreateExpenseRequest({
    required String name,
    required double amount,
    required ExpenseType type,
    required String description,
    required DateTime dateTime,
    required String category,
    @Default(false) bool isRecurring,
    String? recurringPattern,
    String? tags,
    String? receiptUrl,
    @Default(0) double latitude,
    @Default(0) double longitude,
    String? location,
  }) = _CreateExpenseRequest;

  factory CreateExpenseRequest.fromJson(Map<String, dynamic> json) => 
      _$CreateExpenseRequestFromJson(json);
}

/// Expense update request model
@freezed
class UpdateExpenseRequest with _$UpdateExpenseRequest {
  const factory UpdateExpenseRequest({
    String? name,
    double? amount,
    ExpenseType? type,
    String? description,
    DateTime? dateTime,
    String? category,
    bool? isRecurring,
    String? recurringPattern,
    String? tags,
    String? receiptUrl,
    double? latitude,
    double? longitude,
    String? location,
  }) = _UpdateExpenseRequest;

  factory UpdateExpenseRequest.fromJson(Map<String, dynamic> json) => 
      _$UpdateExpenseRequestFromJson(json);
}

/// Expense filter model
@freezed
class ExpenseFilter with _$ExpenseFilter {
  const factory ExpenseFilter({
    List<ExpenseType>? types,
    List<String>? categories,
    DateTime? startDate,
    DateTime? endDate,
    double? minAmount,
    double? maxAmount,
    String? searchQuery,
    bool? isRecurring,
    String? tags,
  }) = _ExpenseFilter;

  /// Create filter for specific time period
  factory ExpenseFilter.forPeriod(TimePeriod period) {
    final (start, end) = period.dateRange;
    return ExpenseFilter(
      startDate: start,
      endDate: end,
    );
  }

  /// Create filter for specific expense type
  factory ExpenseFilter.forType(ExpenseType type) {
    return ExpenseFilter(types: [type]);
  }

  /// Create filter for amount range
  factory ExpenseFilter.forAmountRange(double min, double max) {
    return ExpenseFilter(
      minAmount: min,
      maxAmount: max,
    );
  }
}
