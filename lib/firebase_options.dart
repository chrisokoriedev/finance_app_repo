
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCS-FGysnICPdksZjZww_gt7TRLdgaOTxc',
    appId: '1:760108775186:web:87260e75f380406a25a5cb',
    messagingSenderId: '760108775186',
    projectId: 'expensetracker-12157',
    authDomain: 'expensetracker-12157.firebaseapp.com',
    storageBucket: 'expensetracker-12157.appspot.com',
    measurementId: 'G-FZFVT68WJ9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3-LjRNOTTmAp19vy02pcegzGmzQoxsdI',
    appId: '1:760108775186:android:bddbd7d1f145a5d725a5cb',
    messagingSenderId: '760108775186',
    projectId: 'expensetracker-12157',
    storageBucket: 'expensetracker-12157.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQbLpAHmU8pRmQg85gyheBqbnbaseYKiM',
    appId: '1:760108775186:ios:7ccbc639db800db525a5cb',
    messagingSenderId: '760108775186',
    projectId: 'expensetracker-12157',
    storageBucket: 'expensetracker-12157.appspot.com',
    iosBundleId: 'com.example.expenseApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQbLpAHmU8pRmQg85gyheBqbnbaseYKiM',
    appId: '1:760108775186:ios:0d60409ee46962d525a5cb',
    messagingSenderId: '760108775186',
    projectId: 'expensetracker-12157',
    storageBucket: 'expensetracker-12157.appspot.com',
    iosBundleId: 'com.example.expenseApp.RunnerTests',
  );
}
