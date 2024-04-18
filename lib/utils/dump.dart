// eventLoader: (day) {
                  //   List<DateTime> datesWithEvents = expenseData
                  //       .where((expense) =>
                  //           expense.dateTime.year == day.year &&
                  //           expense.dateTime.month == day.month &&
                  //           expense.dateTime.day == day.day)
                  //       .map((expense) => DateTime(
                  //             expense.dateTime.year,
                  //             expense.dateTime.month,
                  //             expense.dateTime.day,
                  //           ))
                  //       .toList();
                  //   return datesWithEvents;
                  // },

                  // eventLoader: (day) {
                  //   // if (expenseData.isNotEmpty) {
                  //   //   return expenseData.map((e) => e.dateTime).toList();
                  //   // } else {
                  //   //   return expenseData.map((e) => e.dateTime).toList();
                  //   // }
                  //   bool hasEvents = expenseData.any((expense) =>
                  //       expense.dateTime.year == day.year &&
                  //       expense.dateTime.month == day.month &&
                  //       expense.dateTime.day == day.day);
                  //   return hasEvents ? [day] : [];
                  // },// final cloudItemsProvider = FutureProvider<List<CreateExpenseModel>>((ref) async {
//   final box = await ref.watch(itemBoxProvider.future);
//   return box.values.toList()..sort((a, b) => b.dateTime.compareTo(a.dateTime));
// });
// final itemBoxProvider =
//     FutureProvider((ref) => Hive.openBox<CreateExpenseModel>(AppString.hiveDb));