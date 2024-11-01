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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAYvXljTPmOnUzkrPC5ty1CnBpmZdHEWjM',
    appId: '1:876321964074:web:cf8f626e5bd6fd448ac353',
    messagingSenderId: '876321964074',
    projectId: 'socialapptutorial-ab638',
    authDomain: 'socialapptutorial-ab638.firebaseapp.com',
    storageBucket: 'socialapptutorial-ab638.appspot.com',
    measurementId: 'G-WRP9KG81Q7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlM4kYu0uteaD_N6kPfH7HHYZhluvQyj4',
    appId: '1:876321964074:android:cf1334ba670f70d98ac353',
    messagingSenderId: '876321964074',
    projectId: 'socialapptutorial-ab638',
    storageBucket: 'socialapptutorial-ab638.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMxJaQzM177gmIbhABi6re6MrZic1fhaM',
    appId: '1:876321964074:ios:a83b5326554391b38ac353',
    messagingSenderId: '876321964074',
    projectId: 'socialapptutorial-ab638',
    storageBucket: 'socialapptutorial-ab638.appspot.com',
    iosBundleId: 'com.example.socialApp',
  );
}
