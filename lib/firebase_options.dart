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
    apiKey: 'AIzaSyDngbcB_1mh2w7XnhBGqkj_ttjbaUrXf5c',
    appId: '1:735827875404:web:43a4e00b387f70893e06e9',
    messagingSenderId: '735827875404',
    projectId: 'app-pengaduan-ver2',
    authDomain: 'app-pengaduan-ver2.firebaseapp.com',
    storageBucket: 'app-pengaduan-ver2.appspot.com',
    measurementId: 'G-D272XEGP7Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhPakWjYFxgQBN0b2yKYaFY_89NUIUIz0',
    appId: '1:735827875404:android:fb21112a1e2987233e06e9',
    messagingSenderId: '735827875404',
    projectId: 'app-pengaduan-ver2',
    storageBucket: 'app-pengaduan-ver2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXHYbXPFZYl1ZqcGazkVeAdKGk-Lz8mwY',
    appId: '1:735827875404:ios:2a193d6e1bc936c83e06e9',
    messagingSenderId: '735827875404',
    projectId: 'app-pengaduan-ver2',
    storageBucket: 'app-pengaduan-ver2.appspot.com',
    iosClientId: '735827875404-4qvurjfcnc9ua0drss4tdi2oiocej7v3.apps.googleusercontent.com',
    iosBundleId: 'com.example.pengaduanMasyarakatVer2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXHYbXPFZYl1ZqcGazkVeAdKGk-Lz8mwY',
    appId: '1:735827875404:ios:30bc38b940adb7743e06e9',
    messagingSenderId: '735827875404',
    projectId: 'app-pengaduan-ver2',
    storageBucket: 'app-pengaduan-ver2.appspot.com',
    iosClientId: '735827875404-vetafd7urqf2ond1fh2c5s546mvkj5qa.apps.googleusercontent.com',
    iosBundleId: 'com.example.pengaduanMasyarakatVer2.RunnerTests',
  );
}
