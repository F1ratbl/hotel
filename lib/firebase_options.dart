// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyC4Qee3j-SNuQYaPOBU6RJPmnKObqeu240',
    appId: '1:968802539905:web:c2794b1c502e34ebadb080',
    messagingSenderId: '968802539905',
    projectId: 'mg-hill-hotel-c10d4',
    authDomain: 'mg-hill-hotel-c10d4.firebaseapp.com',
    storageBucket: 'mg-hill-hotel-c10d4.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbWX7xtliU4zR75Yycp8rYBLjN7LW3VJM',
    appId: '1:968802539905:android:5a183fa72bcd1e3fadb080',
    messagingSenderId: '968802539905',
    projectId: 'mg-hill-hotel-c10d4',
    storageBucket: 'mg-hill-hotel-c10d4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwYcn0_izLjsPquXY0wC39SZ_ZEPVNOcY',
    appId: '1:968802539905:ios:196a3c5b216576c2adb080',
    messagingSenderId: '968802539905',
    projectId: 'mg-hill-hotel-c10d4',
    storageBucket: 'mg-hill-hotel-c10d4.firebasestorage.app',
    iosBundleId: 'com.example.hotel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwYcn0_izLjsPquXY0wC39SZ_ZEPVNOcY',
    appId: '1:968802539905:ios:196a3c5b216576c2adb080',
    messagingSenderId: '968802539905',
    projectId: 'mg-hill-hotel-c10d4',
    storageBucket: 'mg-hill-hotel-c10d4.firebasestorage.app',
    iosBundleId: 'com.example.hotel',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4Qee3j-SNuQYaPOBU6RJPmnKObqeu240',
    appId: '1:968802539905:web:cb14f6220e4e9de0adb080',
    messagingSenderId: '968802539905',
    projectId: 'mg-hill-hotel-c10d4',
    authDomain: 'mg-hill-hotel-c10d4.firebaseapp.com',
    storageBucket: 'mg-hill-hotel-c10d4.firebasestorage.app',
  );
}
