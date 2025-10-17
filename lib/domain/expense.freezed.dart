// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
mixin _$Expense {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  ExpenseType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  bool get isRecurring => throw _privateConstructorUsedError;
  String? get recurringPattern => throw _privateConstructorUsedError;
  String? get tags => throw _privateConstructorUsedError;
  String? get receiptUrl => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res, Expense>;
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      ExpenseType type,
      String description,
      DateTime dateTime,
      String category,
      String? userId,
      bool isRecurring,
      String? recurringPattern,
      String? tags,
      String? receiptUrl,
      double latitude,
      double longitude,
      String? location,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res, $Val extends Expense>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? type = null,
    Object? description = null,
    Object? dateTime = null,
    Object? category = null,
    Object? userId = freezed,
    Object? isRecurring = null,
    Object? recurringPattern = freezed,
    Object? tags = freezed,
    Object? receiptUrl = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? location = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      recurringPattern: freezed == recurringPattern
          ? _value.recurringPattern
          : recurringPattern // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseImplCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$$ExpenseImplCopyWith(
          _$ExpenseImpl value, $Res Function(_$ExpenseImpl) then) =
      __$$ExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      ExpenseType type,
      String description,
      DateTime dateTime,
      String category,
      String? userId,
      bool isRecurring,
      String? recurringPattern,
      String? tags,
      String? receiptUrl,
      double latitude,
      double longitude,
      String? location,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$ExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseCopyWithImpl<$Res, _$ExpenseImpl>
    implements _$$ExpenseImplCopyWith<$Res> {
  __$$ExpenseImplCopyWithImpl(
      _$ExpenseImpl _value, $Res Function(_$ExpenseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? type = null,
    Object? description = null,
    Object? dateTime = null,
    Object? category = null,
    Object? userId = freezed,
    Object? isRecurring = null,
    Object? recurringPattern = freezed,
    Object? tags = freezed,
    Object? receiptUrl = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? location = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ExpenseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      recurringPattern: freezed == recurringPattern
          ? _value.recurringPattern
          : recurringPattern // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseImpl implements _Expense {
  const _$ExpenseImpl(
      {required this.id,
      required this.name,
      required this.amount,
      required this.type,
      required this.description,
      required this.dateTime,
      required this.category,
      this.userId,
      this.isRecurring = false,
      this.recurringPattern,
      this.tags,
      this.receiptUrl,
      this.latitude = 0,
      this.longitude = 0,
      this.location,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt});

  factory _$ExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double amount;
  @override
  final ExpenseType type;
  @override
  final String description;
  @override
  final DateTime dateTime;
  @override
  final String category;
  @override
  final String? userId;
  @override
  @JsonKey()
  final bool isRecurring;
  @override
  final String? recurringPattern;
  @override
  final String? tags;
  @override
  final String? receiptUrl;
  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  final String? location;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, amount: $amount, type: $type, description: $description, dateTime: $dateTime, category: $category, userId: $userId, isRecurring: $isRecurring, recurringPattern: $recurringPattern, tags: $tags, receiptUrl: $receiptUrl, latitude: $latitude, longitude: $longitude, location: $location, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.recurringPattern, recurringPattern) ||
                other.recurringPattern == recurringPattern) &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      amount,
      type,
      description,
      dateTime,
      category,
      userId,
      isRecurring,
      recurringPattern,
      tags,
      receiptUrl,
      latitude,
      longitude,
      location,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      __$$ExpenseImplCopyWithImpl<_$ExpenseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseImplToJson(
      this,
    );
  }
}

abstract class _Expense implements Expense {
  const factory _Expense(
      {required final String id,
      required final String name,
      required final double amount,
      required final ExpenseType type,
      required final String description,
      required final DateTime dateTime,
      required final String category,
      final String? userId,
      final bool isRecurring,
      final String? recurringPattern,
      final String? tags,
      final String? receiptUrl,
      final double latitude,
      final double longitude,
      final String? location,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$ExpenseImpl;

  factory _Expense.fromJson(Map<String, dynamic> json) = _$ExpenseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get amount;
  @override
  ExpenseType get type;
  @override
  String get description;
  @override
  DateTime get dateTime;
  @override
  String get category;
  @override
  String? get userId;
  @override
  bool get isRecurring;
  @override
  String? get recurringPattern;
  @override
  String? get tags;
  @override
  String? get receiptUrl;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get location;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateExpenseRequest _$CreateExpenseRequestFromJson(Map<String, dynamic> json) {
  return _CreateExpenseRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateExpenseRequest {
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  ExpenseType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  bool get isRecurring => throw _privateConstructorUsedError;
  String? get recurringPattern => throw _privateConstructorUsedError;
  String? get tags => throw _privateConstructorUsedError;
  String? get receiptUrl => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateExpenseRequestCopyWith<CreateExpenseRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateExpenseRequestCopyWith<$Res> {
  factory $CreateExpenseRequestCopyWith(CreateExpenseRequest value,
          $Res Function(CreateExpenseRequest) then) =
      _$CreateExpenseRequestCopyWithImpl<$Res, CreateExpenseRequest>;
  @useResult
  $Res call(
      {String name,
      double amount,
      ExpenseType type,
      String description,
      DateTime dateTime,
      String category,
      bool isRecurring,
      String? recurringPattern,
      String? tags,
      String? receiptUrl,
      double latitude,
      double longitude,
      String? location});
}

/// @nodoc
class _$CreateExpenseRequestCopyWithImpl<$Res,
        $Val extends CreateExpenseRequest>
    implements $CreateExpenseRequestCopyWith<$Res> {
  _$CreateExpenseRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? amount = null,
    Object? type = null,
    Object? description = null,
    Object? dateTime = null,
    Object? category = null,
    Object? isRecurring = null,
    Object? recurringPattern = freezed,
    Object? tags = freezed,
    Object? receiptUrl = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      recurringPattern: freezed == recurringPattern
          ? _value.recurringPattern
          : recurringPattern // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateExpenseRequestImplCopyWith<$Res>
    implements $CreateExpenseRequestCopyWith<$Res> {
  factory _$$CreateExpenseRequestImplCopyWith(_$CreateExpenseRequestImpl value,
          $Res Function(_$CreateExpenseRequestImpl) then) =
      __$$CreateExpenseRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double amount,
      ExpenseType type,
      String description,
      DateTime dateTime,
      String category,
      bool isRecurring,
      String? recurringPattern,
      String? tags,
      String? receiptUrl,
      double latitude,
      double longitude,
      String? location});
}

/// @nodoc
class __$$CreateExpenseRequestImplCopyWithImpl<$Res>
    extends _$CreateExpenseRequestCopyWithImpl<$Res, _$CreateExpenseRequestImpl>
    implements _$$CreateExpenseRequestImplCopyWith<$Res> {
  __$$CreateExpenseRequestImplCopyWithImpl(_$CreateExpenseRequestImpl _value,
      $Res Function(_$CreateExpenseRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? amount = null,
    Object? type = null,
    Object? description = null,
    Object? dateTime = null,
    Object? category = null,
    Object? isRecurring = null,
    Object? recurringPattern = freezed,
    Object? tags = freezed,
    Object? receiptUrl = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? location = freezed,
  }) {
    return _then(_$CreateExpenseRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      recurringPattern: freezed == recurringPattern
          ? _value.recurringPattern
          : recurringPattern // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateExpenseRequestImpl implements _CreateExpenseRequest {
  const _$CreateExpenseRequestImpl(
      {required this.name,
      required this.amount,
      required this.type,
      required this.description,
      required this.dateTime,
      required this.category,
      this.isRecurring = false,
      this.recurringPattern,
      this.tags,
      this.receiptUrl,
      this.latitude = 0,
      this.longitude = 0,
      this.location});

  factory _$CreateExpenseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateExpenseRequestImplFromJson(json);

  @override
  final String name;
  @override
  final double amount;
  @override
  final ExpenseType type;
  @override
  final String description;
  @override
  final DateTime dateTime;
  @override
  final String category;
  @override
  @JsonKey()
  final bool isRecurring;
  @override
  final String? recurringPattern;
  @override
  final String? tags;
  @override
  final String? receiptUrl;
  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  final String? location;

  @override
  String toString() {
    return 'CreateExpenseRequest(name: $name, amount: $amount, type: $type, description: $description, dateTime: $dateTime, category: $category, isRecurring: $isRecurring, recurringPattern: $recurringPattern, tags: $tags, receiptUrl: $receiptUrl, latitude: $latitude, longitude: $longitude, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateExpenseRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.recurringPattern, recurringPattern) ||
                other.recurringPattern == recurringPattern) &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      amount,
      type,
      description,
      dateTime,
      category,
      isRecurring,
      recurringPattern,
      tags,
      receiptUrl,
      latitude,
      longitude,
      location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateExpenseRequestImplCopyWith<_$CreateExpenseRequestImpl>
      get copyWith =>
          __$$CreateExpenseRequestImplCopyWithImpl<_$CreateExpenseRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateExpenseRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateExpenseRequest implements CreateExpenseRequest {
  const factory _CreateExpenseRequest(
      {required final String name,
      required final double amount,
      required final ExpenseType type,
      required final String description,
      required final DateTime dateTime,
      required final String category,
      final bool isRecurring,
      final String? recurringPattern,
      final String? tags,
      final String? receiptUrl,
      final double latitude,
      final double longitude,
      final String? location}) = _$CreateExpenseRequestImpl;

  factory _CreateExpenseRequest.fromJson(Map<String, dynamic> json) =
      _$CreateExpenseRequestImpl.fromJson;

  @override
  String get name;
  @override
  double get amount;
  @override
  ExpenseType get type;
  @override
  String get description;
  @override
  DateTime get dateTime;
  @override
  String get category;
  @override
  bool get isRecurring;
  @override
  String? get recurringPattern;
  @override
  String? get tags;
  @override
  String? get receiptUrl;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get location;
  @override
  @JsonKey(ignore: true)
  _$$CreateExpenseRequestImplCopyWith<_$CreateExpenseRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdateExpenseRequest _$UpdateExpenseRequestFromJson(Map<String, dynamic> json) {
  return _UpdateExpenseRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateExpenseRequest {
  String? get name => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  ExpenseType? get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get dateTime => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  bool? get isRecurring => throw _privateConstructorUsedError;
  String? get recurringPattern => throw _privateConstructorUsedError;
  String? get tags => throw _privateConstructorUsedError;
  String? get receiptUrl => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateExpenseRequestCopyWith<UpdateExpenseRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateExpenseRequestCopyWith<$Res> {
  factory $UpdateExpenseRequestCopyWith(UpdateExpenseRequest value,
          $Res Function(UpdateExpenseRequest) then) =
      _$UpdateExpenseRequestCopyWithImpl<$Res, UpdateExpenseRequest>;
  @useResult
  $Res call(
      {String? name,
      double? amount,
      ExpenseType? type,
      String? description,
      DateTime? dateTime,
      String? category,
      bool? isRecurring,
      String? recurringPattern,
      String? tags,
      String? receiptUrl,
      double? latitude,
      double? longitude,
      String? location});
}

/// @nodoc
class _$UpdateExpenseRequestCopyWithImpl<$Res,
        $Val extends UpdateExpenseRequest>
    implements $UpdateExpenseRequestCopyWith<$Res> {
  _$UpdateExpenseRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? amount = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? dateTime = freezed,
    Object? category = freezed,
    Object? isRecurring = freezed,
    Object? recurringPattern = freezed,
    Object? tags = freezed,
    Object? receiptUrl = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isRecurring: freezed == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool?,
      recurringPattern: freezed == recurringPattern
          ? _value.recurringPattern
          : recurringPattern // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateExpenseRequestImplCopyWith<$Res>
    implements $UpdateExpenseRequestCopyWith<$Res> {
  factory _$$UpdateExpenseRequestImplCopyWith(_$UpdateExpenseRequestImpl value,
          $Res Function(_$UpdateExpenseRequestImpl) then) =
      __$$UpdateExpenseRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      double? amount,
      ExpenseType? type,
      String? description,
      DateTime? dateTime,
      String? category,
      bool? isRecurring,
      String? recurringPattern,
      String? tags,
      String? receiptUrl,
      double? latitude,
      double? longitude,
      String? location});
}

/// @nodoc
class __$$UpdateExpenseRequestImplCopyWithImpl<$Res>
    extends _$UpdateExpenseRequestCopyWithImpl<$Res, _$UpdateExpenseRequestImpl>
    implements _$$UpdateExpenseRequestImplCopyWith<$Res> {
  __$$UpdateExpenseRequestImplCopyWithImpl(_$UpdateExpenseRequestImpl _value,
      $Res Function(_$UpdateExpenseRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? amount = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? dateTime = freezed,
    Object? category = freezed,
    Object? isRecurring = freezed,
    Object? recurringPattern = freezed,
    Object? tags = freezed,
    Object? receiptUrl = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? location = freezed,
  }) {
    return _then(_$UpdateExpenseRequestImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isRecurring: freezed == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool?,
      recurringPattern: freezed == recurringPattern
          ? _value.recurringPattern
          : recurringPattern // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateExpenseRequestImpl implements _UpdateExpenseRequest {
  const _$UpdateExpenseRequestImpl(
      {this.name,
      this.amount,
      this.type,
      this.description,
      this.dateTime,
      this.category,
      this.isRecurring,
      this.recurringPattern,
      this.tags,
      this.receiptUrl,
      this.latitude,
      this.longitude,
      this.location});

  factory _$UpdateExpenseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateExpenseRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final double? amount;
  @override
  final ExpenseType? type;
  @override
  final String? description;
  @override
  final DateTime? dateTime;
  @override
  final String? category;
  @override
  final bool? isRecurring;
  @override
  final String? recurringPattern;
  @override
  final String? tags;
  @override
  final String? receiptUrl;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? location;

  @override
  String toString() {
    return 'UpdateExpenseRequest(name: $name, amount: $amount, type: $type, description: $description, dateTime: $dateTime, category: $category, isRecurring: $isRecurring, recurringPattern: $recurringPattern, tags: $tags, receiptUrl: $receiptUrl, latitude: $latitude, longitude: $longitude, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateExpenseRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.recurringPattern, recurringPattern) ||
                other.recurringPattern == recurringPattern) &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      amount,
      type,
      description,
      dateTime,
      category,
      isRecurring,
      recurringPattern,
      tags,
      receiptUrl,
      latitude,
      longitude,
      location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateExpenseRequestImplCopyWith<_$UpdateExpenseRequestImpl>
      get copyWith =>
          __$$UpdateExpenseRequestImplCopyWithImpl<_$UpdateExpenseRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateExpenseRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateExpenseRequest implements UpdateExpenseRequest {
  const factory _UpdateExpenseRequest(
      {final String? name,
      final double? amount,
      final ExpenseType? type,
      final String? description,
      final DateTime? dateTime,
      final String? category,
      final bool? isRecurring,
      final String? recurringPattern,
      final String? tags,
      final String? receiptUrl,
      final double? latitude,
      final double? longitude,
      final String? location}) = _$UpdateExpenseRequestImpl;

  factory _UpdateExpenseRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateExpenseRequestImpl.fromJson;

  @override
  String? get name;
  @override
  double? get amount;
  @override
  ExpenseType? get type;
  @override
  String? get description;
  @override
  DateTime? get dateTime;
  @override
  String? get category;
  @override
  bool? get isRecurring;
  @override
  String? get recurringPattern;
  @override
  String? get tags;
  @override
  String? get receiptUrl;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get location;
  @override
  @JsonKey(ignore: true)
  _$$UpdateExpenseRequestImplCopyWith<_$UpdateExpenseRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExpenseFilter {
  List<ExpenseType>? get types => throw _privateConstructorUsedError;
  List<String>? get categories => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  double? get minAmount => throw _privateConstructorUsedError;
  double? get maxAmount => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  bool? get isRecurring => throw _privateConstructorUsedError;
  String? get tags => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpenseFilterCopyWith<ExpenseFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseFilterCopyWith<$Res> {
  factory $ExpenseFilterCopyWith(
          ExpenseFilter value, $Res Function(ExpenseFilter) then) =
      _$ExpenseFilterCopyWithImpl<$Res, ExpenseFilter>;
  @useResult
  $Res call(
      {List<ExpenseType>? types,
      List<String>? categories,
      DateTime? startDate,
      DateTime? endDate,
      double? minAmount,
      double? maxAmount,
      String? searchQuery,
      bool? isRecurring,
      String? tags});
}

/// @nodoc
class _$ExpenseFilterCopyWithImpl<$Res, $Val extends ExpenseFilter>
    implements $ExpenseFilterCopyWith<$Res> {
  _$ExpenseFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? types = freezed,
    Object? categories = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
    Object? searchQuery = freezed,
    Object? isRecurring = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      types: freezed == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<ExpenseType>?,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      isRecurring: freezed == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseFilterImplCopyWith<$Res>
    implements $ExpenseFilterCopyWith<$Res> {
  factory _$$ExpenseFilterImplCopyWith(
          _$ExpenseFilterImpl value, $Res Function(_$ExpenseFilterImpl) then) =
      __$$ExpenseFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ExpenseType>? types,
      List<String>? categories,
      DateTime? startDate,
      DateTime? endDate,
      double? minAmount,
      double? maxAmount,
      String? searchQuery,
      bool? isRecurring,
      String? tags});
}

/// @nodoc
class __$$ExpenseFilterImplCopyWithImpl<$Res>
    extends _$ExpenseFilterCopyWithImpl<$Res, _$ExpenseFilterImpl>
    implements _$$ExpenseFilterImplCopyWith<$Res> {
  __$$ExpenseFilterImplCopyWithImpl(
      _$ExpenseFilterImpl _value, $Res Function(_$ExpenseFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? types = freezed,
    Object? categories = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
    Object? searchQuery = freezed,
    Object? isRecurring = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$ExpenseFilterImpl(
      types: freezed == types
          ? _value._types
          : types // ignore: cast_nullable_to_non_nullable
              as List<ExpenseType>?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      isRecurring: freezed == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ExpenseFilterImpl implements _ExpenseFilter {
  const _$ExpenseFilterImpl(
      {final List<ExpenseType>? types,
      final List<String>? categories,
      this.startDate,
      this.endDate,
      this.minAmount,
      this.maxAmount,
      this.searchQuery,
      this.isRecurring,
      this.tags})
      : _types = types,
        _categories = categories;

  final List<ExpenseType>? _types;
  @override
  List<ExpenseType>? get types {
    final value = _types;
    if (value == null) return null;
    if (_types is EqualUnmodifiableListView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _categories;
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final double? minAmount;
  @override
  final double? maxAmount;
  @override
  final String? searchQuery;
  @override
  final bool? isRecurring;
  @override
  final String? tags;

  @override
  String toString() {
    return 'ExpenseFilter(types: $types, categories: $categories, startDate: $startDate, endDate: $endDate, minAmount: $minAmount, maxAmount: $maxAmount, searchQuery: $searchQuery, isRecurring: $isRecurring, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseFilterImpl &&
            const DeepCollectionEquality().equals(other._types, _types) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.minAmount, minAmount) ||
                other.minAmount == minAmount) &&
            (identical(other.maxAmount, maxAmount) ||
                other.maxAmount == maxAmount) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.tags, tags) || other.tags == tags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_types),
      const DeepCollectionEquality().hash(_categories),
      startDate,
      endDate,
      minAmount,
      maxAmount,
      searchQuery,
      isRecurring,
      tags);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseFilterImplCopyWith<_$ExpenseFilterImpl> get copyWith =>
      __$$ExpenseFilterImplCopyWithImpl<_$ExpenseFilterImpl>(this, _$identity);
}

abstract class _ExpenseFilter implements ExpenseFilter {
  const factory _ExpenseFilter(
      {final List<ExpenseType>? types,
      final List<String>? categories,
      final DateTime? startDate,
      final DateTime? endDate,
      final double? minAmount,
      final double? maxAmount,
      final String? searchQuery,
      final bool? isRecurring,
      final String? tags}) = _$ExpenseFilterImpl;

  @override
  List<ExpenseType>? get types;
  @override
  List<String>? get categories;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  double? get minAmount;
  @override
  double? get maxAmount;
  @override
  String? get searchQuery;
  @override
  bool? get isRecurring;
  @override
  String? get tags;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseFilterImplCopyWith<_$ExpenseFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
