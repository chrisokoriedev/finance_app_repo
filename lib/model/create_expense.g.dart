// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_expense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateExpenseModelAdapter extends TypeAdapter<CreateExpenseModel> {
  @override
  final int typeId = 1;

  @override
  CreateExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateExpenseModel(
      name: fields[0] as String,
      amount: fields[1] as double,
      expenseType: fields[2] as String,
      explain: fields[3] as String,
      dateTime: fields[4] as DateTime,
      expenseSubList: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreateExpenseModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.expenseType)
      ..writeByte(3)
      ..write(obj.explain)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.expenseSubList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
