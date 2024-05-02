import 'package:dartz/dartz.dart';
import 'package:expense_app/provider/local_auth.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:local_auth/local_auth.dart';

class BiometricAuthDataSource {
  final LocalAuthentication _localAuth;
  final Ref ref;

  BiometricAuthDataSource(this._localAuth, this.ref);

  Future<Either<String, dynamic>> authenticateWithBiometrics() async {
    final isBiometricAuthEnabled =
        ref.read(biometricAuthStateProvider.notifier);
    debugPrint('start authentication');
    bool isBiometricSupported = await _localAuth.isDeviceSupported();

    if (!isBiometricSupported) {
      EasyLoading.showError(
          'Biometric authentication not supported on this device.');
      return right(false);
    }
    try {
      bool isAuthenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate to access nora',
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true, useErrorDialogs: true));
      if (isAuthenticated) {
        debugPrint('start authentication successful');
        isBiometricAuthEnabled.state = isAuthenticated;
        final sharedPreferences = ref.read(sharedPreferencesProvider);
        sharedPreferences.setBool(AppString.bioAuth, isAuthenticated);
        EasyLoading.showSuccess(' Biometric authentication successful');
        return right(true);
      } else {
        isBiometricAuthEnabled.state = isAuthenticated;
        debugPrint('start  authentication failed');
        return left('Biometric authentication failed');
      }
    } on PlatformException catch (e) {
      isBiometricAuthEnabled.state = false;
      debugPrint('catch authentication failed');
      debugPrint(e.toString());
      return left(e.message ?? 'Biometric authentication error');
    }
  }

  Future<Either<String, dynamic>> loginWithBiometrics() async {
    try {
      bool isAuthenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate to access sensitive data',
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true, useErrorDialogs: true));
      if (isAuthenticated) {
        EasyLoading.showSuccess(' Biometric authentication successful');
        return right(true);
      } else {
        return left('Biometric authentication failed');
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return left(e.message ?? 'Biometric authentication error');
    }
  }

  Future<Either<String, dynamic>> disableBiometricAuth() async {
    try {
      bool isDisabledBioAuth = await _localAuth.stopAuthentication();
      if (isDisabledBioAuth) {
        final sharedPreferences = ref.read(sharedPreferencesProvider);
        sharedPreferences.setBool(AppString.bioAuth, false);
        final isBiometricAuthEnabled =
            ref.read(biometricAuthStateProvider.notifier);
        isBiometricAuthEnabled.state = false;
        debugPrint('disabled');
        EasyLoading.showSuccess('Biometric authentication has been disabled');
        return right(true);
      } else {
        return left('Biometric authentication is still enabled');
      }
    } on PlatformException catch (e) {
      debugPrint('catch authentication failed');
      debugPrint(e.toString());
      return left(e.message ?? 'Biometric authentication error');
    }
  }
}
