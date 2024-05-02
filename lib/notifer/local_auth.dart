import 'package:expense_app/domain/local_auth.dart';
import 'package:expense_app/provider/local_auth.dart';
import 'package:expense_app/state/local_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BiometricAuthNotifier extends StateNotifier<LocalAuthState> {
  final BiometricAuthDataSource _bioAuth;
  BiometricAuthNotifier(this._bioAuth) : super(const LocalAuthState.initial());

  Future createdBioWithLocalAuth() async {
    state = const LocalAuthState.loading();
    final response = await _bioAuth.authenticateWithBiometrics();
    state = response.fold(
      (failed) => const LocalAuthState.failed(failed: false),
      (response) => const LocalAuthState.success(success: true),
    );
  }

  Future disableBioWithLocalAuth() async {
    state = const LocalAuthState.loading();
    final response = await _bioAuth.disableBiometricAuth();
    state = response.fold(
      (failed) => const LocalAuthState.failed(failed: false),
      (response) => const LocalAuthState.success(success: true),
    );
  }
}

class BiometricAuthNotifierII extends StateNotifier<LocalAuthState> {
  final BiometricAuthDataSource _bioAuth;
  BiometricAuthNotifierII(this._bioAuth)
      : super(const LocalAuthState.initial());

  Future loginBioWithLocalAuth() async {
    state = const LocalAuthState.loading();
    final response = await _bioAuth.loginWithBiometrics();
    state = response.fold(
      (failed) => const LocalAuthState.failed(failed: false),
      (response) => const LocalAuthState.success(success: true),
    );
  }
}

final bioAuthNotifierProviderII =
    StateNotifierProvider<BiometricAuthNotifierII, LocalAuthState>(
  (ref) => BiometricAuthNotifierII(
    ref.read(bioAuthDataSourceProvider),
  ),
);

final bioAuthNotifierProvider =
    StateNotifierProvider<BiometricAuthNotifier, LocalAuthState>(
  (ref) => BiometricAuthNotifier(
    ref.read(bioAuthDataSourceProvider),
  ),
);
