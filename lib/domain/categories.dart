import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpenseCatergory {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final Ref ref;

  ExpenseCatergory(this._firebaseAuth, this._firebaseFirestore, this.ref);

  Future<Either<String, dynamic>> addUserSubCategories(String categore) async {
    try {
      final firestoreInstance = _firebaseFirestore;
      final userId = _firebaseAuth.currentUser!.uid;
      await firestoreInstance
          .collection(AppString.expenseSubList)
          .doc(userId)
          .update({'expenseCategory': [categore]});

      return left('Success');
    } catch (e) {
      debugPrint(e.toString());
      return Right(e.toString());
    }
  }
}
