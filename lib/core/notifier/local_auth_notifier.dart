import 'package:expense_app/core/domain/local_auth.dart';
import 'package:expense_app/core/state/local_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Single notifier for biometric authentication, handling the three commands:
/// create (enable), disable, and login.
class BiometricAuthNotifier extends StateNotifier<LocalAuthState> {
  final BiometricAuthDataSource _bioAuth;
  BiometricAuthNotifier(this._bioAuth) : super(const LocalAuthState.initial());

  Future<void> createdBioWithLocalAuth() async {
    state = const LocalAuthState.loading();
    final response = await _bioAuth.authenticateWithBiometrics();
    state = response.fold(
      (failed) => const LocalAuthState.failed(failed: false),
      (response) => const LocalAuthState.success(success: true),
    );
  }

  Future<void> disableBioWithLocalAuth() async {
    state = const LocalAuthState.loading();
    final response = await _bioAuth.disableBiometricAuth();
    state = response.fold(
      (failed) => const LocalAuthState.failed(failed: false),
      (response) => const LocalAuthState.success(success: true),
    );
  }

  Future<void> loginBioWithLocalAuth() async {
    state = const LocalAuthState.loading();
    final response = await _bioAuth.loginWithBiometrics();
    state = response.fold(
      (failed) => const LocalAuthState.failed(failed: false),
      (response) => const LocalAuthState.success(success: true),
    );
  }
}
