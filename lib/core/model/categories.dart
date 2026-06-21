import 'package:expense_app/core/utils/string_app.dart';

class ExpenseCategoryModel {
  final List expenseCategory;

  ExpenseCategoryModel({required this.expenseCategory});
  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) {
    return ExpenseCategoryModel(
        expenseCategory: json[AppString.expenseSubList] as List);
  }
  Map<String, dynamic> toJson() {
    return {
      AppString.expenseSubList: expenseCategory,
    };
  }

  ExpenseCategoryModel copyWith({List? expenseCategory}) {
    return ExpenseCategoryModel(expenseCategory: expenseCategory!);
  }
}
