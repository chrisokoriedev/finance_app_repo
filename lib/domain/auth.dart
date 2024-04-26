import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  final Ref ref;

  AuthDataSource(this._firebaseAuth, this.ref);

  Future<Either<String, User>> continueWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await _firebaseAuth.signInWithCredential(credential);

        return right(response.user!);
      } else {
        return left('Unknown Error');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return left(e.message ?? 'Unknow Error');
    } on PlatformException catch (e) {
      debugPrint(e.message);

      return left(e.message ?? 'sign_in_failed');
    }
  }

  Future<Either<String, dynamic>> signOutGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      if (_firebaseAuth.currentUser != null) {
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
      final googleSignIn = GoogleSignIn();
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
