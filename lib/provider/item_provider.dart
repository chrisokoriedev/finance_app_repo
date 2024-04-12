import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final itemBoxProvider = FutureProvider<Box<CreateExpenseModel>>(
  (ref) => Hive.openBox<CreateExpenseModel>(AppString.hiveDb),
);

final itemsProvider = FutureProvider<List<CreateExpenseModel>>((ref) async {
  final box = await ref.watch(itemBoxProvider.future);
  return box.values.toList()..sort((a, b) => b.dateTime.compareTo(a.dateTime));
});
