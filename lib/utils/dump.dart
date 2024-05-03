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




// final cloudItemsProvider =
//     FutureProvider<List<CreateExpenseModel>>((ref) async {
//   final fireAuth =
//       ref.watch(firebaseAuthProvider.select((value) => value.currentUser!.uid));
//   final fireStore = ref.watch(fireStoreProvider);
//   final cacheManager = DefaultCacheManager();

//   FileInfo? fileInfo;
//   try {
//     fileInfo = await cacheManager.getFileFromCache(AppString.userExpense);
//   } catch (e) {
//     debugPrint('Error checking cache: $e');
//   }

//   if (fileInfo != null) {
//     try {
//       final cachedData =
//           await cacheManager.getFileFromCache(AppString.userExpense);
//       if (cachedData != null) {
//         final List<dynamic> decodedData = jsonDecode(cachedData as String);
//         final expenseList = decodedData.map((json) {
//           if (json is Map<String, dynamic>) {
//             return CreateExpenseModel.fromJson(json);
//           } else {
//             throw const FormatException('Invalid JSON format');
//           }
//         }).toList()
//           ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
//         return expenseList;
//       } else {
//         throw const FormatException('Cached data is null');
//       }
//     } catch (e) {
//       debugPrint('Error reading cached data: $e');
//     }
//   }

//   try {
//     final querySnapshot = await fireStore
//         .collection(AppString.expense)
//         .doc(fireAuth)
//         .collection(AppString.userExpense)
//         .get();
//     List<CreateExpenseModel> expenseList = [];
//     for (var doc in querySnapshot.docs) {
//       final data = doc.data();
//       if (data.containsKey('expenseType')) {
//         expenseList.add(CreateExpenseModel.fromJson(data));
//       }
//     }

//     // Convert expenseList to List<Map<String, dynamic>> before caching
//     final encodedExpenseList =
//         expenseList.map((model) => model.toJson()).toList();
//     await cacheManager.putFile(
//         AppString.userExpense, utf8.encode(jsonEncode(encodedExpenseList)));

//     return expenseList.toList()
//       ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
//   } catch (e) {
//     debugPrint('Error fetching data from Firestore: $e');
//     return [];
//   }
// });
// final cloudItemsProvider =
//     FutureProvider<List<CreateExpenseModel>>((ref) async {
//   final fireAuth =
//       ref.watch(firebaseAuthProvider.select((value) => value.currentUser!.uid));
//   final fireStore = ref.watch(fireStoreProvider);

//   final cacheManager = DefaultCacheManager();

//   FileInfo? fileInfo;
//   try {
//     fileInfo = await cacheManager.getFileFromCache(AppString.userExpense);
//   } catch (e) {
//     debugPrint('Error checking cache: $e');
//   }

//   if (fileInfo != null && fileInfo.validTill.isAfter(DateTime.now())) {
//     try {
//       final cachedData = await cacheManager.getFileFromCache(AppString.userExpense); // Use getFileAsString to get the cached data as a string
//       final List<dynamic> jsonData = jsonDecode(cachedData!.file.readAsStringSync()); // Decode the cached data string to a List
//       final expenseList = jsonData.map((x) => CreateExpenseModel.fromJson(x)).toList();
//       return expenseList..sort((a, b) => b.dateTime.compareTo(a.dateTime));
//     } catch (e) {
//       debugPrint('Error reading cached data: $e');
//     }
//   }

//   try {
//     final querySnapshot = await fireStore
//         .collection(AppString.expense)
//         .doc(fireAuth)
//         .collection(AppString.userExpense)
//         .get();
//     List<CreateExpenseModel> expenseList = [];
//     for (var doc in querySnapshot.docs) {
//       final data = doc.data();
//       if (data.containsKey('expenseType')) {
//         expenseList.add(CreateExpenseModel.fromJson(data));
//       }
//     }

//     await cacheManager.putFile(
//         AppString.userExpense, utf8.encode(jsonEncode(expenseList)));

//     return expenseList..sort((a, b) => b.dateTime.compareTo(a.dateTime));
//   } catch (e) {
//     debugPrint('Error fetching data from Firestore: $e');
//     return []; 
//   }
// });
