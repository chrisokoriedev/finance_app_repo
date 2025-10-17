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
    state = response.when(
      success: (response) => AuthenticationState.authenticated(
          user: response, loginTime: DateTime.now()),
      failure: (error, exception) => AuthenticationState.unauthenticated(
          message: error, exception: exception),
      loading: () => const AuthenticationState.loading(),
    );
  }

  ///method to sign out  with google
  Future<void> signOutGoogle() async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.signOutGoogle();
    state = response.when(
      success: (response) => AuthenticationState.success(
          message: response, timestamp: DateTime.now()),
      failure: (error, exception) => AuthenticationState.failed(
          message: error, exception: exception, timestamp: DateTime.now()),
      loading: () => const AuthenticationState.loading(),
    );
  }

  ///method to delete user account on google firebase
  Future<void> deleteUserAccount() async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.deleteUserAccount();
    state = response.when(
      success: (response) => AuthenticationState.success(
          message: response, timestamp: DateTime.now()),
      failure: (error, exception) => AuthenticationState.failed(
          message: error, exception: exception, timestamp: DateTime.now()),
      loading: () => const AuthenticationState.loading(),
    );
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthenticationState>(
  (ref) => AuthNotifier(
    ref.read(authDataSourceProvider),
  ),
);
