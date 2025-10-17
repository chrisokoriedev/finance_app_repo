import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'result.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences sharedPreferences;
  final Ref ref;

  AuthDataSource(this._firebaseAuth, this.ref, this.sharedPreferences);

  Future<Result<User>> continueWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await _firebaseAuth.signInWithCredential(credential);

        return Result.success(response.user!);
      } else {
        return const Result.failure('Unknown Error');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return Result.failure(e.message ?? 'Unknown Error');
    } on PlatformException catch (e) {
      debugPrint(e.message);
      return Result.failure(e.message ?? 'sign_in_failed');
    }
  }

  Future<Result<String>> signOutGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (_firebaseAuth.currentUser != null) {
        await sharedPreferences.clear();
        await _firebaseAuth.signOut();
        await googleSignIn.signOut();

        return const Result.success('Sign-out successful');
      } else {
        return const Result.failure('Logout operation already performed');
      }
    } on FirebaseAuthException catch (e) {
      return Result.failure(e.message ?? 'Unknown Error');
    } on PlatformException catch (e) {
      return Result.failure(e.message ?? 'sign_out_failed');
    } on SocketException catch (e) {
      return Result.failure(e.message);
    }
  }

  Future<Result<String>> deleteUserAccount() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser!.delete();
        await googleSignIn.disconnect();
        return const Result.success('User account deleted');
      } else {
        return const Result.failure('Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      return Result.failure(e.message ?? 'Unknown Error');
    } on PlatformException catch (e) {
      return Result.failure(e.message ?? 'sign_out_failed');
    } on SocketException catch (e) {
      return Result.failure(e.message);
    }
  }
}
