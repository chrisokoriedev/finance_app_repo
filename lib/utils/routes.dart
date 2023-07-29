import 'package:expense_app/features/CreateExpense/create_expense_view.dart';
import 'package:expense_app/features/homepage/bottom.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const root = '/';
  static const createExpenseView = '/createExpenseView';
  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: root,
        name: 'splash',
        builder: (context, state) => const BottomComponent(),
      ),
      GoRoute(
        name: '/createExpenseView',
        path: createExpenseView,
        builder: (context, state) => const CreateExpenseView(),
      ),
    ],
  );
  static GoRouter get router => _router;
}