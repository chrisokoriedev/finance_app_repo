// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$firestoreHash() => r'ef4a6b0737caace50a6d79dd3e4e2aa1bc3031d5';

/// Firestore provider
///
/// Copied from [firestore].
@ProviderFor(firestore)
final firestoreProvider = AutoDisposeProvider<FirebaseFirestore>.internal(
  firestore,
  name: r'firestoreProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$firestoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirestoreRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$expenseBoxHash() => r'f3c7d072a2ebdee9493f3d768814ed057c1a7d78';

/// Hive box provider for expenses
///
/// Copied from [expenseBox].
@ProviderFor(expenseBox)
final expenseBoxProvider = AutoDisposeFutureProvider<Box<Expense>>.internal(
  expenseBox,
  name: r'expenseBoxProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$expenseBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExpenseBoxRef = AutoDisposeFutureProviderRef<Box<Expense>>;
String _$categoryBoxHash() => r'3837b8ddb6b2e1f9c71dde6d821b48aae603a185';

/// Hive box provider for categories
///
/// Copied from [categoryBox].
@ProviderFor(categoryBox)
final categoryBoxProvider = AutoDisposeFutureProvider<Box<String>>.internal(
  categoryBox,
  name: r'categoryBoxProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$categoryBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CategoryBoxRef = AutoDisposeFutureProviderRef<Box<String>>;
String _$pendingSyncBoxHash() => r'6bb1ae80aeeb65f0fb9f09c886eb28b6066d06cf';

/// Hive box provider for pending sync
///
/// Copied from [pendingSyncBox].
@ProviderFor(pendingSyncBox)
final pendingSyncBoxProvider =
    AutoDisposeFutureProvider<Box<PendingSyncItem>>.internal(
  pendingSyncBox,
  name: r'pendingSyncBoxProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingSyncBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PendingSyncBoxRef = AutoDisposeFutureProviderRef<Box<PendingSyncItem>>;
String _$expenseLocalDataSourceHash() =>
    r'f06461e7967ea5212548f6675f56da72331b9cf1';

/// Local data source provider
///
/// Copied from [expenseLocalDataSource].
@ProviderFor(expenseLocalDataSource)
final expenseLocalDataSourceProvider =
    AutoDisposeProvider<ExpenseLocalDataSource>.internal(
  expenseLocalDataSource,
  name: r'expenseLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExpenseLocalDataSourceRef
    = AutoDisposeProviderRef<ExpenseLocalDataSource>;
String _$expenseRemoteDataSourceHash() =>
    r'a432648cd615d846d47824468bd09092fb03c74e';

/// Remote data source provider
///
/// Copied from [expenseRemoteDataSource].
@ProviderFor(expenseRemoteDataSource)
final expenseRemoteDataSourceProvider =
    AutoDisposeProvider<ExpenseRemoteDataSource>.internal(
  expenseRemoteDataSource,
  name: r'expenseRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExpenseRemoteDataSourceRef
    = AutoDisposeProviderRef<ExpenseRemoteDataSource>;
String _$expenseRepositoryHash() => r'bfe5682044f5e7c1b2a284686873c282e8427325';

/// Expense repository provider
///
/// Copied from [expenseRepository].
@ProviderFor(expenseRepository)
final expenseRepositoryProvider =
    AutoDisposeProvider<ExpenseRepository>.internal(
  expenseRepository,
  name: r'expenseRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExpenseRepositoryRef = AutoDisposeProviderRef<ExpenseRepository>;
String _$expensesNotifierHash() => r'b97320c0b2f9188bda0f0f117bb76b3c5b20f306';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ExpensesNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Result<List<Expense>>> {
  late final ExpenseFilter? filter;
  late final int? limit;

  FutureOr<Result<List<Expense>>> build({
    ExpenseFilter? filter,
    int? limit,
  });
}

/// Expenses provider with filtering and pagination
///
/// Copied from [ExpensesNotifier].
@ProviderFor(ExpensesNotifier)
const expensesNotifierProvider = ExpensesNotifierFamily();

/// Expenses provider with filtering and pagination
///
/// Copied from [ExpensesNotifier].
class ExpensesNotifierFamily extends Family<AsyncValue<Result<List<Expense>>>> {
  /// Expenses provider with filtering and pagination
  ///
  /// Copied from [ExpensesNotifier].
  const ExpensesNotifierFamily();

  /// Expenses provider with filtering and pagination
  ///
  /// Copied from [ExpensesNotifier].
  ExpensesNotifierProvider call({
    ExpenseFilter? filter,
    int? limit,
  }) {
    return ExpensesNotifierProvider(
      filter: filter,
      limit: limit,
    );
  }

  @override
  ExpensesNotifierProvider getProviderOverride(
    covariant ExpensesNotifierProvider provider,
  ) {
    return call(
      filter: provider.filter,
      limit: provider.limit,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'expensesNotifierProvider';
}

/// Expenses provider with filtering and pagination
///
/// Copied from [ExpensesNotifier].
class ExpensesNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ExpensesNotifier, Result<List<Expense>>> {
  /// Expenses provider with filtering and pagination
  ///
  /// Copied from [ExpensesNotifier].
  ExpensesNotifierProvider({
    ExpenseFilter? filter,
    int? limit,
  }) : this._internal(
          () => ExpensesNotifier()
            ..filter = filter
            ..limit = limit,
          from: expensesNotifierProvider,
          name: r'expensesNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$expensesNotifierHash,
          dependencies: ExpensesNotifierFamily._dependencies,
          allTransitiveDependencies:
              ExpensesNotifierFamily._allTransitiveDependencies,
          filter: filter,
          limit: limit,
        );

  ExpensesNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
    required this.limit,
  }) : super.internal();

  final ExpenseFilter? filter;
  final int? limit;

  @override
  FutureOr<Result<List<Expense>>> runNotifierBuild(
    covariant ExpensesNotifier notifier,
  ) {
    return notifier.build(
      filter: filter,
      limit: limit,
    );
  }

  @override
  Override overrideWith(ExpensesNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ExpensesNotifierProvider._internal(
        () => create()
          ..filter = filter
          ..limit = limit,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ExpensesNotifier,
      Result<List<Expense>>> createElement() {
    return _ExpensesNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesNotifierProvider &&
        other.filter == filter &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExpensesNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<Result<List<Expense>>> {
  /// The parameter `filter` of this provider.
  ExpenseFilter? get filter;

  /// The parameter `limit` of this provider.
  int? get limit;
}

class _ExpensesNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ExpensesNotifier,
        Result<List<Expense>>> with ExpensesNotifierRef {
  _ExpensesNotifierProviderElement(super.provider);

  @override
  ExpenseFilter? get filter => (origin as ExpensesNotifierProvider).filter;
  @override
  int? get limit => (origin as ExpensesNotifierProvider).limit;
}

String _$expenseNotifierHash() => r'e02d4c215b01f930f79752ebacc1bf648bafff16';

abstract class _$ExpenseNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Result<Expense>> {
  late final String id;

  FutureOr<Result<Expense>> build(
    String id,
  );
}

/// Single expense provider
///
/// Copied from [ExpenseNotifier].
@ProviderFor(ExpenseNotifier)
const expenseNotifierProvider = ExpenseNotifierFamily();

/// Single expense provider
///
/// Copied from [ExpenseNotifier].
class ExpenseNotifierFamily extends Family<AsyncValue<Result<Expense>>> {
  /// Single expense provider
  ///
  /// Copied from [ExpenseNotifier].
  const ExpenseNotifierFamily();

  /// Single expense provider
  ///
  /// Copied from [ExpenseNotifier].
  ExpenseNotifierProvider call(
    String id,
  ) {
    return ExpenseNotifierProvider(
      id,
    );
  }

  @override
  ExpenseNotifierProvider getProviderOverride(
    covariant ExpenseNotifierProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'expenseNotifierProvider';
}

/// Single expense provider
///
/// Copied from [ExpenseNotifier].
class ExpenseNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ExpenseNotifier, Result<Expense>> {
  /// Single expense provider
  ///
  /// Copied from [ExpenseNotifier].
  ExpenseNotifierProvider(
    String id,
  ) : this._internal(
          () => ExpenseNotifier()..id = id,
          from: expenseNotifierProvider,
          name: r'expenseNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$expenseNotifierHash,
          dependencies: ExpenseNotifierFamily._dependencies,
          allTransitiveDependencies:
              ExpenseNotifierFamily._allTransitiveDependencies,
          id: id,
        );

  ExpenseNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<Result<Expense>> runNotifierBuild(
    covariant ExpenseNotifier notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ExpenseNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ExpenseNotifierProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ExpenseNotifier, Result<Expense>>
      createElement() {
    return _ExpenseNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpenseNotifierProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExpenseNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<Result<Expense>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ExpenseNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ExpenseNotifier,
        Result<Expense>> with ExpenseNotifierRef {
  _ExpenseNotifierProviderElement(super.provider);

  @override
  String get id => (origin as ExpenseNotifierProvider).id;
}

String _$categoriesNotifierHash() =>
    r'28eeb39924750355b9b33f1a3ec43c8c6b102b68';

/// Categories provider
///
/// Copied from [CategoriesNotifier].
@ProviderFor(CategoriesNotifier)
final categoriesNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CategoriesNotifier, Result<List<String>>>.internal(
  CategoriesNotifier.new,
  name: r'categoriesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoriesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CategoriesNotifier = AutoDisposeAsyncNotifier<Result<List<String>>>;
String _$expenseSummaryNotifierHash() =>
    r'5744f0c7ad19a2cbbfb184d9a017a1b4668a58b1';

abstract class _$ExpenseSummaryNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Result<Map<String, double>>> {
  late final TimePeriod? period;
  late final ExpenseType? type;

  FutureOr<Result<Map<String, double>>> build({
    TimePeriod? period,
    ExpenseType? type,
  });
}

/// Expense summary provider
///
/// Copied from [ExpenseSummaryNotifier].
@ProviderFor(ExpenseSummaryNotifier)
const expenseSummaryNotifierProvider = ExpenseSummaryNotifierFamily();

/// Expense summary provider
///
/// Copied from [ExpenseSummaryNotifier].
class ExpenseSummaryNotifierFamily
    extends Family<AsyncValue<Result<Map<String, double>>>> {
  /// Expense summary provider
  ///
  /// Copied from [ExpenseSummaryNotifier].
  const ExpenseSummaryNotifierFamily();

  /// Expense summary provider
  ///
  /// Copied from [ExpenseSummaryNotifier].
  ExpenseSummaryNotifierProvider call({
    TimePeriod? period,
    ExpenseType? type,
  }) {
    return ExpenseSummaryNotifierProvider(
      period: period,
      type: type,
    );
  }

  @override
  ExpenseSummaryNotifierProvider getProviderOverride(
    covariant ExpenseSummaryNotifierProvider provider,
  ) {
    return call(
      period: provider.period,
      type: provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'expenseSummaryNotifierProvider';
}

/// Expense summary provider
///
/// Copied from [ExpenseSummaryNotifier].
class ExpenseSummaryNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ExpenseSummaryNotifier,
        Result<Map<String, double>>> {
  /// Expense summary provider
  ///
  /// Copied from [ExpenseSummaryNotifier].
  ExpenseSummaryNotifierProvider({
    TimePeriod? period,
    ExpenseType? type,
  }) : this._internal(
          () => ExpenseSummaryNotifier()
            ..period = period
            ..type = type,
          from: expenseSummaryNotifierProvider,
          name: r'expenseSummaryNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$expenseSummaryNotifierHash,
          dependencies: ExpenseSummaryNotifierFamily._dependencies,
          allTransitiveDependencies:
              ExpenseSummaryNotifierFamily._allTransitiveDependencies,
          period: period,
          type: type,
        );

  ExpenseSummaryNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.period,
    required this.type,
  }) : super.internal();

  final TimePeriod? period;
  final ExpenseType? type;

  @override
  FutureOr<Result<Map<String, double>>> runNotifierBuild(
    covariant ExpenseSummaryNotifier notifier,
  ) {
    return notifier.build(
      period: period,
      type: type,
    );
  }

  @override
  Override overrideWith(ExpenseSummaryNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ExpenseSummaryNotifierProvider._internal(
        () => create()
          ..period = period
          ..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        period: period,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ExpenseSummaryNotifier,
      Result<Map<String, double>>> createElement() {
    return _ExpenseSummaryNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpenseSummaryNotifierProvider &&
        other.period == period &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, period.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExpenseSummaryNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<Result<Map<String, double>>> {
  /// The parameter `period` of this provider.
  TimePeriod? get period;

  /// The parameter `type` of this provider.
  ExpenseType? get type;
}

class _ExpenseSummaryNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ExpenseSummaryNotifier,
        Result<Map<String, double>>> with ExpenseSummaryNotifierRef {
  _ExpenseSummaryNotifierProviderElement(super.provider);

  @override
  TimePeriod? get period => (origin as ExpenseSummaryNotifierProvider).period;
  @override
  ExpenseType? get type => (origin as ExpenseSummaryNotifierProvider).type;
}

String _$createExpenseNotifierHash() =>
    r'9e3903d05b3a31bfa270eb8920fc9d658e34afd0';

/// Expense creation provider
///
/// Copied from [CreateExpenseNotifier].
@ProviderFor(CreateExpenseNotifier)
final createExpenseNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CreateExpenseNotifier, Result<Expense>>.internal(
  CreateExpenseNotifier.new,
  name: r'createExpenseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createExpenseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateExpenseNotifier = AutoDisposeAsyncNotifier<Result<Expense>>;
String _$updateExpenseNotifierHash() =>
    r'367c50510f8f366fd31ba76a4a44679d4cacd759';

/// Expense update provider
///
/// Copied from [UpdateExpenseNotifier].
@ProviderFor(UpdateExpenseNotifier)
final updateExpenseNotifierProvider = AutoDisposeAsyncNotifierProvider<
    UpdateExpenseNotifier, Result<Expense>>.internal(
  UpdateExpenseNotifier.new,
  name: r'updateExpenseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateExpenseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateExpenseNotifier = AutoDisposeAsyncNotifier<Result<Expense>>;
String _$deleteExpenseNotifierHash() =>
    r'cc227b57038e3c0bdf3f98bda5982a8b42db1215';

/// Expense deletion provider
///
/// Copied from [DeleteExpenseNotifier].
@ProviderFor(DeleteExpenseNotifier)
final deleteExpenseNotifierProvider = AutoDisposeAsyncNotifierProvider<
    DeleteExpenseNotifier, Result<void>>.internal(
  DeleteExpenseNotifier.new,
  name: r'deleteExpenseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteExpenseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteExpenseNotifier = AutoDisposeAsyncNotifier<Result<void>>;
String _$syncNotifierHash() => r'88e4bd8cdd13702bee5d2bb77b841e9cb9260171';

/// Sync provider for offline/online synchronization
///
/// Copied from [SyncNotifier].
@ProviderFor(SyncNotifier)
final syncNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SyncNotifier, Result<void>>.internal(
  SyncNotifier.new,
  name: r'syncNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SyncNotifier = AutoDisposeAsyncNotifier<Result<void>>;
String _$expenseFilterNotifierHash() =>
    r'84e4dadada7bd028f4773fdaa0ed5409874f03fa';

/// Filter state provider
///
/// Copied from [ExpenseFilterNotifier].
@ProviderFor(ExpenseFilterNotifier)
final expenseFilterNotifierProvider =
    AutoDisposeNotifierProvider<ExpenseFilterNotifier, ExpenseFilter>.internal(
  ExpenseFilterNotifier.new,
  name: r'expenseFilterNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseFilterNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseFilterNotifier = AutoDisposeNotifier<ExpenseFilter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
