import 'package:expense_app/features/CreateExpense/create_expense_view.dart';
import 'package:expense_app/features/TransactionList/view_expense_timeline.dart';
import 'package:expense_app/features/auth/auth.dart';
import 'package:expense_app/features/auth/bio_auth.dart';
import 'package:expense_app/features/auth/splashscreen.dart';
import 'package:expense_app/features/homepage/main_control.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const root = '/';
  static const authScreen = '/authScreen';
  static const bioScreen = '/bioScreen';
  static const mainControl = '/mainControl';
  static const createExpenseView = '/createExpenseView';
  static const viewAllExpenses = '/viewAllExpenses';
  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: root,
        name: 'splash',
        builder: (context, state) {
          final auth = FirebaseAuth.instance;
          return auth.currentUser == null
              ? const AuthScreen()
              : const SplashScreen();
        },
      ),
      GoRoute(
        name: '/authScreen',
        path: authScreen,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        name: '/bioScreen',
        path: bioScreen,
        builder: (context, state) => const BioAuthScreen(),
      ),
      GoRoute(
        name: '/mainControl',
        path: mainControl,
        builder: (context, state) => const MainControlComponent(),
      ),
      GoRoute(
        name: '/createExpenseView',
        path: createExpenseView,
        builder: (context, state) => const CreateExpenseView(),
      ),
      GoRoute(
        name: '/viewAllExpenses',
        path: viewAllExpenses,
        builder: (context, state) => const ViewExpensesTimeline(),
      ),
    ],
  );
  static GoRouter get router => _router;
}
