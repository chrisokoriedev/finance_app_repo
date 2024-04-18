import 'package:expense_app/domain/auth.dart';
import 'package:expense_app/provider/auth.dart';
import 'package:expense_app/state/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthenticationState> {
  AuthNotifier(this._dataSource) : super(const AuthenticationState.initial());

  final AuthDataSource _dataSource;

  ///method to sign in with google
  Future<void> continueWithGoogle() async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.continueWithGoogle();
    state = response.fold(
      (error) => AuthenticationState.unauthenticated(message: error),
      (response) => AuthenticationState.authenticated(user: response),
    );
  }

  ///method to sign out  with google
  Future<void> signOutGoogle() async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.signOutGoogle();
    state = response.fold(
      (error) => AuthenticationState.failed(failed: error),
      (response) => AuthenticationState.success(success: response),
    );
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthenticationState>(
  (ref) => AuthNotifier(
    ref.read(authDataSourceProvider),
  ),
);
