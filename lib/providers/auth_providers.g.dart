// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'e7434892b510bbf881dbfaaffbb34cb3be601b01';

/// SharedPreferences provider
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef = AutoDisposeProviderRef<SharedPreferences>;
String _$firebaseAuthHash() => r'7791bf70ce0f01bf991a53a76abc915478673c0b';

/// Firebase Auth provider
///
/// Copied from [firebaseAuth].
@ProviderFor(firebaseAuth)
final firebaseAuthProvider = AutoDisposeProvider<FirebaseAuth>.internal(
  firebaseAuth,
  name: r'firebaseAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$firebaseAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseAuthRef = AutoDisposeProviderRef<FirebaseAuth>;
String _$authDataSourceHash() => r'5ca059bbc48478527e014498938c7d3c1d12a3f1';

/// Auth data source provider
///
/// Copied from [authDataSource].
@ProviderFor(authDataSource)
final authDataSourceProvider = AutoDisposeProvider<AuthDataSource>.internal(
  authDataSource,
  name: r'authDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthDataSourceRef = AutoDisposeProviderRef<AuthDataSource>;
String _$currentUserHash() => r'550582aa5e6e9ac1f9baaed87f47ae2ad0bf954c';

/// Current user provider
///
/// Copied from [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeProvider<User?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserRef = AutoDisposeProviderRef<User?>;
String _$isAuthenticatedHash() => r'fe6f954f2d7938a820a402d3f97973c87930d8b5';

/// Authentication status provider
///
/// Copied from [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$userDisplayNameHash() => r'a6e0eb226373b40036dec8bfa4433690800139a7';

/// User display name provider
///
/// Copied from [userDisplayName].
@ProviderFor(userDisplayName)
final userDisplayNameProvider = AutoDisposeProvider<String>.internal(
  userDisplayName,
  name: r'userDisplayNameProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userDisplayNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserDisplayNameRef = AutoDisposeProviderRef<String>;
String _$userEmailHash() => r'2fc3630d34d7e824b1516d8c1cd9bc31c1f5271d';

/// User email provider
///
/// Copied from [userEmail].
@ProviderFor(userEmail)
final userEmailProvider = AutoDisposeProvider<String>.internal(
  userEmail,
  name: r'userEmailProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userEmailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserEmailRef = AutoDisposeProviderRef<String>;
String _$userPhotoUrlHash() => r'c5839bebe070281db25159d64c8ce610c67e5fdb';

/// User photo URL provider
///
/// Copied from [userPhotoUrl].
@ProviderFor(userPhotoUrl)
final userPhotoUrlProvider = AutoDisposeProvider<String?>.internal(
  userPhotoUrl,
  name: r'userPhotoUrlProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userPhotoUrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserPhotoUrlRef = AutoDisposeProviderRef<String?>;
String _$authNotifierHash() => r'c7a7dbddcb5cc30f314f60f50ae7e238fba123b4';

/// Authentication state notifier
///
/// Copied from [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider = AutoDisposeAsyncNotifierProvider<AuthNotifier,
    Result<AuthenticationState>>.internal(
  AuthNotifier.new,
  name: r'authNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthNotifier = AutoDisposeAsyncNotifier<Result<AuthenticationState>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
