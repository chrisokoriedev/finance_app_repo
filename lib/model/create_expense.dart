class CreateExpenseModel {
  String name;
  double amount;
  String expenseType;
  String explain;
  String dateTime; // Change the type to String for JSON compatibility
  String expenseSubList;

  CreateExpenseModel({
    required this.name,
    required this.amount,
    required this.expenseType,
    required this.explain,
    required this.dateTime,
    required this.expenseSubList,
  });

  factory CreateExpenseModel.fromJson(Map<String, dynamic> json) {
    return CreateExpenseModel(
      name: json['name'] as String,
      amount: json['amount'] as double,
      expenseType: json['expenseType'] as String,
      explain: json['explain'] as String,
      dateTime: json['dateTime'] as String, // Change to String
      expenseSubList: json['expenseSubList'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'expenseType': expenseType,
      'explain': explain,
      'dateTime': dateTime, // Change to String
      'expenseSubList': expenseSubList,
    };
  }
}
