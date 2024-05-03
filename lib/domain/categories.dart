import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final expenseCatergoryState = StateProvider((ref) => ExpenseCatergory(
    ref.read(firebaseAuthProvider), ref.read(fireStoreProvider), ref));

class ExpenseCatergory {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final Ref ref;

  ExpenseCatergory(this._firebaseAuth, this._firebaseFirestore, this.ref);

  Future<Either<String, dynamic>> addUserSubCategories(String category) async {
    try {
      final firestoreInstance = _firebaseFirestore;
      final userId = _firebaseAuth.currentUser!.uid;
      if (userId.isNotEmpty) {
        await firestoreInstance
            .collection(AppString.expenseSubList)
            .doc(userId)
            .collection(AppString.expenseSubList)
            .add({AppString.expenseSubList: category});
      }
      return left('Success');
    } catch (e) {
      debugPrint(e.toString());
      return Right(e.toString());
    }
  }

  Future<Either<String, dynamic>> getUserSubCategories() async {
    try {
      final firestoreInstance = _firebaseFirestore;
      final userId = _firebaseAuth.currentUser!.uid;
      if (userId.isNotEmpty) {
        await firestoreInstance
            .collection(AppString.expenseSubList)
            .doc(userId)
            .get();
      }
      return left('Success');
    } catch (e) {
      debugPrint(e.toString());
      return Right(e.toString());
    }
  }
}
