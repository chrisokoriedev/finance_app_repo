import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final cloudItemsProvider =
//     StateNotifierProvider<CloudItemsStateNotifier, List<CreateExpenseModel>>(
//         (ref) => CloudItemsStateNotifier(ref, ref.watch(firebaseAuthProvider)));

// class CloudItemsStateNotifier extends StateNotifier<List<CreateExpenseModel>> {
//   final Ref ref;
//   final FirebaseAuth firebaseAuth;

//   CloudItemsStateNotifier(this.ref, this.firebaseAuth) : super([]);

//   Future<void> fetchAndSortItems() async {
//     final fireStore = ref.watch(fireStoreProvider);
//     final QuerySnapshot querySnapshot = await fireStore
//         .collection(AppString.expense)
//         .doc(firebaseAuth.currentUser!.uid)
//         .collection(AppString.userExpense)
//         .get();

//     List<CreateExpenseModel> expenseList = [];
//     for (var doc in querySnapshot.docs) {
//       final data = doc.data() as Map<String, dynamic>;
//       if (data.containsKey('expenseType')) {
//         expenseList.add(CreateExpenseModel.fromJson(data));
//       }
//     }

//     expenseList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
//     state = expenseList;
//   }

//   void initState() {
//     fetchAndSortItems(); // Fetch and sort data on initialization
//   }
// }
