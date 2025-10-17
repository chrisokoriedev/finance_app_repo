// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$ExpenseTypeEnumMap, json['type']),
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      category: json['category'] as String,
      userId: json['userId'] as String?,
      isRecurring: json['isRecurring'] as bool? ?? false,
      recurringPattern: json['recurringPattern'] as String?,
      tags: json['tags'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      location: json['location'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'type': _$ExpenseTypeEnumMap[instance.type]!,
      'description': instance.description,
      'dateTime': instance.dateTime.toIso8601String(),
      'category': instance.category,
      'userId': instance.userId,
      'isRecurring': instance.isRecurring,
      'recurringPattern': instance.recurringPattern,
      'tags': instance.tags,
      'receiptUrl': instance.receiptUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

const _$ExpenseTypeEnumMap = {
  ExpenseType.income: 'income',
  ExpenseType.expense: 'expense',
  ExpenseType.debt: 'debt',
};

_$CreateExpenseRequestImpl _$$CreateExpenseRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateExpenseRequestImpl(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$ExpenseTypeEnumMap, json['type']),
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      category: json['category'] as String,
      isRecurring: json['isRecurring'] as bool? ?? false,
      recurringPattern: json['recurringPattern'] as String?,
      tags: json['tags'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$$CreateExpenseRequestImplToJson(
        _$CreateExpenseRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'type': _$ExpenseTypeEnumMap[instance.type]!,
      'description': instance.description,
      'dateTime': instance.dateTime.toIso8601String(),
      'category': instance.category,
      'isRecurring': instance.isRecurring,
      'recurringPattern': instance.recurringPattern,
      'tags': instance.tags,
      'receiptUrl': instance.receiptUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
    };

_$UpdateExpenseRequestImpl _$$UpdateExpenseRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateExpenseRequestImpl(
      name: json['name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      type: $enumDecodeNullable(_$ExpenseTypeEnumMap, json['type']),
      description: json['description'] as String?,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      category: json['category'] as String?,
      isRecurring: json['isRecurring'] as bool?,
      recurringPattern: json['recurringPattern'] as String?,
      tags: json['tags'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      location: json['location'] as String?,
    );

Map<String, dynamic> _$$UpdateExpenseRequestImplToJson(
        _$UpdateExpenseRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'type': _$ExpenseTypeEnumMap[instance.type],
      'description': instance.description,
      'dateTime': instance.dateTime?.toIso8601String(),
      'category': instance.category,
      'isRecurring': instance.isRecurring,
      'recurringPattern': instance.recurringPattern,
      'tags': instance.tags,
      'receiptUrl': instance.receiptUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
    };
