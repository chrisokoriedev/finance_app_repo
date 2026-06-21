class CreateExpenseModel {
  /// Firestore document id. Null for models not yet persisted; populated from
  /// `doc.id` when read back so records can be deleted/updated by id.
  String? id;
  String name;
  double amount;
  String expenseType;
  String explain;
  DateTime dateTime;
  String expenseSubList;
  CreateExpenseModel(
      {this.id,
      required this.name,
      required this.amount,
      required this.expenseType,
      required this.explain,
      required this.dateTime,
      required this.expenseSubList});
  factory CreateExpenseModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return CreateExpenseModel(
        id: id,
        name: json['name'] as String,
        amount: (json['amount'] as num).toDouble(),
        expenseType: json['expenseType'] as String,
        explain: json['explain'] as String,
        dateTime: DateTime.parse(json['dateTime'] as String),
        expenseSubList: json['expenseSubList'] as String);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'expenseType': expenseType,
      'explain': explain,
      'dateTime': dateTime,
      'expenseSubList': expenseSubList
    };
  }

  CreateExpenseModel copyWith(
      {String? id,
      String? name,
      double? amount,
      String? expenseType,
      String? explain,
      DateTime? dateTime,
      String? expenseSubList}) {
    return CreateExpenseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        expenseType: expenseType ?? this.expenseType,
        explain: explain ?? this.explain,
        dateTime: dateTime ?? this.dateTime,
        expenseSubList: expenseSubList ?? this.expenseSubList);
  }
}
