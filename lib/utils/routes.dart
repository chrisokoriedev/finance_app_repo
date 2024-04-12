import 'package:expense_app/features/CreateExpense/create_expense_view.dart';
import 'package:expense_app/features/TransactionList/view_all_expense.dart';
import 'package:expense_app/features/auth/auth.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const root = '/';
  static const authScreen = '/authScreen';
  static const createExpenseView = '/createExpenseView';
  static const viewAllExpenses = '/viewAllExpenses';
  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: root,
        name: 'splash',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        name: '/createExpenseView',
        path: createExpenseView,
        builder: (context, state) => const CreateExpenseView(),
      ),
      GoRoute(
        name: '/authScreen',
        path: authScreen,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        name: '/viewAllExpenses',
        path: viewAllExpenses,
        builder: (context, state) => const ViewAllExpense(),
      ),
    ],
  );
  static GoRouter get router => _router;
}
