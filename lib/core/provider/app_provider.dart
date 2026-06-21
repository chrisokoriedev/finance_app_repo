/// Central registry for every [StateNotifierProvider] in the app.
///
/// Notifier *classes* live in `lib/notifier/` and their *state* classes live in
/// `lib/state/`. This file is the single place where notifiers are wired to
/// their datasources and exposed as providers, so the UI only ever imports
/// `provider/app_provider.dart` to reach app state.
library;

import 'package:expense_app/core/domain/cal.dart';
import 'package:expense_app/core/domain/categories.dart';
import 'package:expense_app/core/notifier/auth_notifier.dart';
import 'package:expense_app/core/notifier/create_expense_notifier.dart';
import 'package:expense_app/core/notifier/expense_category_notifier.dart';
import 'package:expense_app/core/notifier/local_auth_notifier.dart';
import 'package:expense_app/core/provider/auth.dart';
import 'package:expense_app/core/provider/local_auth.dart';
import 'package:expense_app/core/state/auth.dart';
import 'package:expense_app/core/state/local.dart';
import 'package:expense_app/core/state/local_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Authentication (Google sign-in / sign-out / delete account).
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthenticationState>(
  (ref) => AuthNotifier(
    ref.read(authDataSourceProvider),
  ),
);

/// Creating and deleting expense records.
final createExpenseNotifierProvider =
    StateNotifierProvider<CreateExpenseNotifier, AppStateManager>(
  (ref) => CreateExpenseNotifier(
    ref.read(addExpenseProvider),
  ),
);

/// Managing user-defined expense sub-categories.
final expenseCategoryNotifier =
    StateNotifierProvider<ExpenseCategoryNotifier, AppStateManager>(
  (ref) => ExpenseCategoryNotifier(
    ref.read(expenseCategoryState),
  ),
);

/// Biometric authentication — create (enable), disable, and login.
final bioAuthNotifierProvider =
    StateNotifierProvider<BiometricAuthNotifier, LocalAuthState>(
  (ref) => BiometricAuthNotifier(
    ref.read(bioAuthDataSourceProvider),
  ),
);
