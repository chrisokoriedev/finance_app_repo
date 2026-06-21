import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final fireStoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final remoteConfigProvider =
    Provider<FirebaseRemoteConfig>((ref) => FirebaseRemoteConfig.instance);
