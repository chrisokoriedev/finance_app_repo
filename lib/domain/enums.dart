import 'package:flutter/material.dart';

/// Enhanced enum for expense types with methods and properties
enum ExpenseType {
  income('Income', '💰', Colors.green, 'income'),
  expense('Expense', '💸', Colors.red, 'expense'),
  debt('Debt', '📊', Colors.blue, 'debt');

  const ExpenseType(this.displayName, this.emoji, this.color, this.value);

  final String displayName;
  final String emoji;
  final Color color;
  final String value;

  /// Get expense type from string value
  static ExpenseType fromString(String value) {
    return ExpenseType.values.firstWhere(
      (type) => type.value == value.toLowerCase(),
      orElse: () => ExpenseType.expense,
    );
  }

  /// Check if this is a positive transaction (income)
  bool get isPositive => this == ExpenseType.income;

  /// Check if this is a negative transaction (expense or debt)
  bool get isNegative => this == ExpenseType.expense || this == ExpenseType.debt;

  /// Get the sign multiplier for calculations
  double get multiplier => isPositive ? 1.0 : -1.0;
}

/// Enhanced enum for time periods with methods
enum TimePeriod {
  today('Today', 1),
  week('This Week', 7),
  month('This Month', 30),
  year('This Year', 365);

  const TimePeriod(this.displayName, this.days);

  final String displayName;
  final int days;

  /// Get date range for this period
  (DateTime start, DateTime end) get dateRange {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: days));
    return (start, now);
  }
}

/// Enhanced enum for greeting times
enum Greeting {
  morning('Good Morning', 6, 12),
  afternoon('Good Afternoon', 12, 17),
  evening('Good Evening', 17, 22),
  night('Good Night', 22, 6);

  const Greeting(this.displayName, this.startHour, this.endHour);

  final String displayName;
  final int startHour;
  final int endHour;

  /// Get current greeting based on time
  static Greeting getCurrent() {
    final hour = DateTime.now().hour;
    
    if (hour >= morning.startHour && hour < morning.endHour) {
      return morning;
    } else if (hour >= afternoon.startHour && hour < afternoon.endHour) {
      return afternoon;
    } else if (hour >= evening.startHour && hour < evening.endHour) {
      return evening;
    } else {
      return night;
    }
  }
}

/// Enhanced enum for app themes
enum AppTheme {
  light('Light', ThemeMode.light),
  dark('Dark', ThemeMode.dark),
  system('System', ThemeMode.system);

  const AppTheme(this.displayName, this.themeMode);

  final String displayName;
  final ThemeMode themeMode;

  /// Get theme from string
  static AppTheme fromString(String value) {
    return AppTheme.values.firstWhere(
      (theme) => theme.name == value.toLowerCase(),
      orElse: () => AppTheme.system,
    );
  }
}
