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
    apiKey: 'AIzaSyDX0Vns63tEx-nRbYdfyx5hxLgK6im1fIQ',
    appId: '1:679310893999:web:91f83fd6d4aacd9596c55a',
    messagingSenderId: '679310893999',
    projectId: 'planificadorbodas',
    authDomain: 'planificadorbodas.firebaseapp.com',
    storageBucket: 'planificadorbodas.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2GI00C9T6KlLW8AugawxG6cSCfmu5WnI',
    appId: '1:679310893999:android:709683c3dbc391b796c55a',
    messagingSenderId: '679310893999',
    projectId: 'planificadorbodas',
    storageBucket: 'planificadorbodas.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVNMVxWH1Jm2_8MFYpI1-AJqHmv15tsJg',
    appId: '1:679310893999:ios:9c3807e1362624db96c55a',
    messagingSenderId: '679310893999',
    projectId: 'planificadorbodas',
    storageBucket: 'planificadorbodas.firebasestorage.app',
    iosBundleId: 'com.example.planificadorBodas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVNMVxWH1Jm2_8MFYpI1-AJqHmv15tsJg',
    appId: '1:679310893999:ios:9c3807e1362624db96c55a',
    messagingSenderId: '679310893999',
    projectId: 'planificadorbodas',
    storageBucket: 'planificadorbodas.firebasestorage.app',
    iosBundleId: 'com.example.planificadorBodas',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDX0Vns63tEx-nRbYdfyx5hxLgK6im1fIQ',
    appId: '1:679310893999:web:cb9cf59c094fc0be96c55a',
    messagingSenderId: '679310893999',
    projectId: 'planificadorbodas',
    authDomain: 'planificadorbodas.firebaseapp.com',
    storageBucket: 'planificadorbodas.firebasestorage.app',
  );

}