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
    apiKey: 'AIzaSyDy7ANP-zRNsldSj95KgkS_zz-C2SmRIGQ',
    appId: '1:1077580082010:web:d1bf4ca808979851c4a163',
    messagingSenderId: '1077580082010',
    projectId: 'ithub-flutter-1',
    authDomain: 'ithub-flutter-1.firebaseapp.com',
    storageBucket: 'ithub-flutter-1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNnycgX_OViJmO9sWff7i7UN1AQlVrsRk',
    appId: '1:1077580082010:android:8c37b66c8402fa80c4a163',
    messagingSenderId: '1077580082010',
    projectId: 'ithub-flutter-1',
    storageBucket: 'ithub-flutter-1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8fkC6TH4rTPwSYnV6RwRjcYuTCjQytZA',
    appId: '1:1077580082010:ios:aac9865f940c7554c4a163',
    messagingSenderId: '1077580082010',
    projectId: 'ithub-flutter-1',
    storageBucket: 'ithub-flutter-1.appspot.com',
    iosBundleId: 'com.example.ithubFlutter1',
  );
}
