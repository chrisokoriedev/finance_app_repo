import 'package:hive/hive.dart';
part 'create_expense.g.dart';

@HiveType(typeId: 1)
class CreateExpenseModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String amount;
  @HiveField(2)
  String expenseType;
  @HiveField(3)
  String explain;
  @HiveField(4)
  DateTime dateTime;
  @HiveField(5)
  String expenseSubList;
  CreateExpenseModel(
    this.name,
    this.amount,
    this.expenseType,
    this.explain,
    this.dateTime,
    this.expenseSubList,
  );
}
