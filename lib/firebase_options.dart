// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
    apiKey: 'AIzaSyAWLu1CvlcrqetFJuethwVDjFiD4LBamcI',
    appId: '1:151682514824:web:00e8a3acfdbd6bd6bb843d',
    messagingSenderId: '151682514824',
    projectId: 'bonchtigersapp',
    authDomain: 'bonchtigersapp.firebaseapp.com',
    storageBucket: 'bonchtigersapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsk8aQypWLtf-fA2nZIF9XcuLlr0V6fhY',
    appId: '1:151682514824:android:86f0cd11631ee8f7bb843d',
    messagingSenderId: '151682514824',
    projectId: 'bonchtigersapp',
    storageBucket: 'bonchtigersapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2ySKhMdfKgTZI05XmmAMnvGye3l2dHQo',
    appId: '1:151682514824:ios:aaba18f62eb53af6bb843d',
    messagingSenderId: '151682514824',
    projectId: 'bonchtigersapp',
    storageBucket: 'bonchtigersapp.appspot.com',
    iosClientId:
        '151682514824-rmrq75vrh2093rm924v6ae16os57tt00.apps.googleusercontent.com',
    iosBundleId: 'com.example.bonchTigersApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2ySKhMdfKgTZI05XmmAMnvGye3l2dHQo',
    appId: '1:151682514824:ios:e41bf61fa05f1e08bb843d',
    messagingSenderId: '151682514824',
    projectId: 'bonchtigersapp',
    storageBucket: 'bonchtigersapp.appspot.com',
    iosClientId:
        '151682514824-9m8tnd2i7qabbcsdn8c2en9r2tdg3bfc.apps.googleusercontent.com',
    iosBundleId: 'com.example.bonchTigersApp.RunnerTests',
  );
}