import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences sharedPreferences;
  final Ref ref;

  AuthDataSource(this._firebaseAuth, this.ref, this.sharedPreferences);

  /// google_sign_in 7.x requires [GoogleSignIn.initialize] to be called once
  /// before authenticating. Guarded so repeated sign-in attempts only init once.
  static bool _googleInitialized = false;

  Future<void> _ensureGoogleInitialized() async {
    if (!_googleInitialized) {
      await GoogleSignIn.instance.initialize();
      _googleInitialized = true;
    }
  }

  Future<Either<String, User>> continueWithGoogle() async {
    try {
      await _ensureGoogleInitialized();
      // authenticate() returns a non-null account or throws on cancel/failure.
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final response = await _firebaseAuth.signInWithCredential(credential);

      return right(response.user!);
    } on GoogleSignInException catch (e) {
      debugPrint(e.toString());
      return left(e.code == GoogleSignInExceptionCode.canceled
          ? 'Sign in canceled'
          : (e.description ?? 'sign_in_failed'));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return left(e.message ?? 'Unknow Error');
    } on PlatformException catch (e) {
      debugPrint(e.message);

      return left(e.message ?? 'sign_in_failed');
    }
  }

  Future<Either<String, User>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return right(credential.user!);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return left(e.message ?? 'Sign in failed');
    } catch (e) {
      debugPrint(e.toString());
      return left(e.toString());
    }
  }

  Future<Either<String, User>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return right(credential.user!);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return left(e.message ?? 'Registration failed');
    } catch (e) {
      debugPrint(e.toString());
      return left(e.toString());
    }
  }

  Future<Either<String, dynamic>> signOutGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      if (_firebaseAuth.currentUser != null) {
        await sharedPreferences.clear();
        await _firebaseAuth.signOut();
        await googleSignIn.signOut();

        return right('Sign-out successful');
      } else {
        return left('Logout operation already performed');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknow Error');
    } on PlatformException catch (e) {
      return left(e.message ?? 'sign_out_failed');
    } on SocketException catch (e) {
      return left(e.message);
    }
  }

  Future<Either<String, dynamic>> deleteUserAccount() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser!.delete();
        await googleSignIn.disconnect();
        return right('User account deleted');
      } else {
        return left('Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknow Error');
    } on PlatformException catch (e) {
      return left(e.message ?? 'sign_out_failed');
    } on SocketException catch (e) {
      return left(e.message);
    }
  }
}
