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
    apiKey: 'AIzaSyDSswZIv2nb_SxYdDEet6w62zN0-Kjd3sg',
    appId: '1:166761062665:web:616bdd75a3c76948fcf3d8',
    messagingSenderId: '166761062665',
    projectId: 'fir-master-dfb19',
    authDomain: 'fir-master-dfb19.firebaseapp.com',
    storageBucket: 'fir-master-dfb19.appspot.com',
    measurementId: 'G-MNS77N6KCL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxds59mWwBwN7907Gh7i-sQ3__8Tu_4uo',
    appId: '1:166761062665:android:d11cfdbfe91fe4d3fcf3d8',
    messagingSenderId: '166761062665',
    projectId: 'fir-master-dfb19',
    storageBucket: 'fir-master-dfb19.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDn1slRsCmMTt7uteasNLFr_0YsfRMx0bA',
    appId: '1:166761062665:ios:77252d8b8e0b12f9fcf3d8',
    messagingSenderId: '166761062665',
    projectId: 'fir-master-dfb19',
    storageBucket: 'fir-master-dfb19.appspot.com',
    iosBundleId: 'com.example.firebaseMaster',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDn1slRsCmMTt7uteasNLFr_0YsfRMx0bA',
    appId: '1:166761062665:ios:e79586e31c49d6a7fcf3d8',
    messagingSenderId: '166761062665',
    projectId: 'fir-master-dfb19',
    storageBucket: 'fir-master-dfb19.appspot.com',
    iosBundleId: 'com.example.firebaseMaster.RunnerTests',
  );
}
