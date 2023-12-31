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
    apiKey: 'AIzaSyCxFET8WT-IX37P5BQ3iHBzhz0Jp9pCHdQ',
    appId: '1:697793517238:web:e16214264a2c87e8327817',
    messagingSenderId: '697793517238',
    projectId: 'mahasamundtourism',
    authDomain: 'mahasamundtourism.firebaseapp.com',
    storageBucket: 'mahasamundtourism.appspot.com',
    measurementId: 'G-DV5QGN9GQS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4BArgZAvXEa4aA2VISHcxbXClFxuIjJY',
    appId: '1:697793517238:android:d7177baf8ea9c9a1327817',
    messagingSenderId: '697793517238',
    projectId: 'mahasamundtourism',
    storageBucket: 'mahasamundtourism.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDiOkXk22KxWllQqx8EaPbWGtHeKot3qY',
    appId: '1:697793517238:ios:cca78b3b64394984327817',
    messagingSenderId: '697793517238',
    projectId: 'mahasamundtourism',
    storageBucket: 'mahasamundtourism.appspot.com',
    iosBundleId: 'com.beamingindia.mahasamundtourism',
  );
}
