import 'package:expense_app/core/domain/auth.dart';
import 'package:expense_app/core/provider/local_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'firebase.dart';

final authDataSourceProvider = StateProvider<AuthDataSource>((ref) =>
    AuthDataSource(ref.read(firebaseAuthProvider), ref,
        ref.watch(sharedPreferencesProvider)));
final localAuthProvider =
    Provider<LocalAuthentication>((ref) => LocalAuthentication());
