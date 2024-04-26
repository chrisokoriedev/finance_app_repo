import 'package:expense_app/domain/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'firebase.dart';

final authDataSourceProvider = StateProvider<AuthDataSource>(
    (ref) => AuthDataSource(ref.read(firebaseAuthProvider), ref));
final localAuthProvider =
    Provider<LocalAuthentication>((ref) => LocalAuthentication());
