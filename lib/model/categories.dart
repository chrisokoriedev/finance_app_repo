import 'package:expense_app/utils/string_app.dart';

class ExpenseCatergoryModel {
  final List expenseCategory;

  ExpenseCatergoryModel({required this.expenseCategory});
  factory ExpenseCatergoryModel.fromJson(Map<String, dynamic> json) {
    return ExpenseCatergoryModel(
        expenseCategory: json[AppString.expenseSubList] as List);
  }
  Map<String, dynamic> toJson() {
    return {
      AppString.expenseSubList: expenseCategory,
    };
  }

  ExpenseCatergoryModel copyWith({List? expenseCategory}) {
    return ExpenseCatergoryModel(expenseCategory: expenseCategory!);
  }
}
