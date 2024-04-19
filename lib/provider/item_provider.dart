import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cloudItemsProvider = FutureProvider((ref) async {
  final fireAuth =
      ref.watch(firebaseAuthProvider.select((value) => value.currentUser!.uid));
  final fireStore = ref.watch(fireStoreProvider);
  final QuerySnapshot querySnapshot = await fireStore
      .collection(AppString.expense)
      .doc(fireAuth)
      .collection(AppString.userExpense)
      .get();
  List<CreateExpenseModel> expenseList = [];
  for (var doc in querySnapshot.docs) {
    final data = doc.data() as Map<String, dynamic>;
    if (data.containsKey('expenseType')) {
      expenseList.add(CreateExpenseModel.fromJson(data));
    }
  }
  return expenseList.toList()..sort((a, b) => b.dateTime.compareTo(a.dateTime));
});

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
