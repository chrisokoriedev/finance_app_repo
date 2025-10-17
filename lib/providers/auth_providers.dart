import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/auth.dart';
import '../state/auth.dart';
import '../domain/result.dart';

part 'auth_providers.g.dart';

/// SharedPreferences provider
@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
}

/// Firebase Auth provider
@riverpod
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

/// Auth data source provider
@riverpod
AuthDataSource authDataSource(AuthDataSourceRef ref) {
  return AuthDataSource(
    ref.watch(firebaseAuthProvider),
    ref,
    ref.watch(sharedPreferencesProvider),
  );
}

/// Authentication state notifier
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<Result<AuthenticationState>> build() async {
    // Listen to auth state changes
    ref.listen(firebaseAuthProvider, (previous, next) {
      next.authStateChanges().listen((user) {
        if (user != null) {
          state = AsyncValue.data(Result.success(
            AuthenticationState.authenticated(
              user: user,
              loginTime: DateTime.now(),
            ),
          ));
        } else {
          state = const AsyncValue.data(Result.success(
            AuthenticationState.unauthenticated(),
          ));
        }
      });
    });

    // Return initial state
    final user = ref.watch(firebaseAuthProvider).currentUser;
    if (user != null) {
      return Result.success(
        AuthenticationState.authenticated(
          user: user,
          loginTime: DateTime.now(),
        ),
      );
    } else {
      return const Result.success(AuthenticationState.unauthenticated());
    }
  }

  /// Sign in with Google
  Future<Result<AuthenticationState>> signInWithGoogle() async {
    state = const AsyncValue.loading();
    
    try {
      final dataSource = ref.watch(authDataSourceProvider);
      final result = await dataSource.continueWithGoogle();
      
      if (result.isSuccess && result.data != null) {
        final authState = AuthenticationState.authenticated(
          user: result.data!,
          loginTime: DateTime.now(),
        );
        state = AsyncValue.data(Result.success(authState));
        return Result.success(authState);
      } else {
        final authState = AuthenticationState.unauthenticated(
          message: result.errorMessage ?? 'Authentication failed',
        );
        state = AsyncValue.data(Result.success(authState));
        return Result.success(authState);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return Result.failure('Sign in failed: ${e.toString()}');
    }
  }

  /// Sign out
  Future<Result<AuthenticationState>> signOut() async {
    state = const AsyncValue.loading();
    
    try {
      final dataSource = ref.watch(authDataSourceProvider);
      final result = await dataSource.signOutGoogle();
      
      if (result.isSuccess && result.data != null) {
        final authState = AuthenticationState.success(
          message: result.data!,
          timestamp: DateTime.now(),
        );
        state = AsyncValue.data(Result.success(authState));
        return Result.success(authState);
      } else {
        final authState = AuthenticationState.failed(
          message: result.errorMessage ?? 'Sign out failed',
        );
        state = AsyncValue.data(Result.success(authState));
        return Result.success(authState);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return Result.failure('Sign out failed: ${e.toString()}');
    }
  }

  /// Delete user account
  Future<Result<AuthenticationState>> deleteAccount() async {
    state = const AsyncValue.loading();
    
    try {
      final dataSource = ref.watch(authDataSourceProvider);
      final result = await dataSource.deleteUserAccount();
      
      if (result.isSuccess && result.data != null) {
        final authState = AuthenticationState.success(
          message: result.data!,
          timestamp: DateTime.now(),
        );
        state = AsyncValue.data(Result.success(authState));
        return Result.success(authState);
      } else {
        final authState = AuthenticationState.failed(
          message: result.errorMessage ?? 'Account deletion failed',
        );
        state = AsyncValue.data(Result.success(authState));
        return Result.success(authState);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return Result.failure('Account deletion failed: ${e.toString()}');
    }
  }

  /// Refresh auth state
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// Current user provider
@riverpod
User? currentUser(CurrentUserRef ref) {
  return ref.watch(firebaseAuthProvider).currentUser;
}

/// Authentication status provider
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
}

/// User display name provider
@riverpod
String userDisplayName(UserDisplayNameRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.displayName ?? '';
}

/// User email provider
@riverpod
String userEmail(UserEmailRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.email ?? '';
}

/// User photo URL provider
@riverpod
String? userPhotoUrl(UserPhotoUrlRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.photoURL;
}
