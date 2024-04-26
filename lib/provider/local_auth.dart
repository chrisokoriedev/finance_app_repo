import 'package:expense_app/domain/local_auth.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
final localAuthProvider =
    Provider<LocalAuthentication>((ref) => LocalAuthentication());
final biometricAuthStateProvider = StateProvider<bool>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return sharedPreferences.getBool(AppString.bioAuth) ?? false;
});

final bioAuthDataSourceProvider = Provider<BiometricAuthDataSource>(
  (ref) => BiometricAuthDataSource(ref.read(localAuthProvider), ref),
);
