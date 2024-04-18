import 'package:expense_app/domain/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase.dart';

final authDataSourceProvider = StateProvider<AuthDataSource>(
    (ref) => AuthDataSource(ref.read(firebaseAuthProvider)));
