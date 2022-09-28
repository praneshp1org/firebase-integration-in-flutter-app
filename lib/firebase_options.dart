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
    apiKey: 'AIzaSyDNFzFgkcaBZSHkC-olWptkNyDpN6T9Vrk',
    appId: '1:1053222214149:web:e8b1314edbd40203adda6c',
    messagingSenderId: '1053222214149',
    projectId: 'fir-flutter-931f7',
    authDomain: 'fir-flutter-931f7.firebaseapp.com',
    storageBucket: 'fir-flutter-931f7.appspot.com',
    measurementId: 'G-Z0RVR0M8X7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBitG3imXGOjnDZrwauCjIRtc2Olwo8CQw',
    appId: '1:1053222214149:android:aa8d982cbd0c3aecadda6c',
    messagingSenderId: '1053222214149',
    projectId: 'fir-flutter-931f7',
    storageBucket: 'fir-flutter-931f7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBWE5AUsgu3CyS9rGJKon8i4XdWejx_WFA',
    appId: '1:1053222214149:ios:8c3c35e454c85584adda6c',
    messagingSenderId: '1053222214149',
    projectId: 'fir-flutter-931f7',
    storageBucket: 'fir-flutter-931f7.appspot.com',
    iosClientId: '1053222214149-gvcp3jgfudlq3jkastl37gj7r79c3vdl.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseCrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBWE5AUsgu3CyS9rGJKon8i4XdWejx_WFA',
    appId: '1:1053222214149:ios:8c3c35e454c85584adda6c',
    messagingSenderId: '1053222214149',
    projectId: 'fir-flutter-931f7',
    storageBucket: 'fir-flutter-931f7.appspot.com',
    iosClientId: '1053222214149-gvcp3jgfudlq3jkastl37gj7r79c3vdl.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseCrud',
  );
}
