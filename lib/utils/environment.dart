import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../firebase/firebase_options_dev.dart';
// import '../firebase/firebase_options_prod.dart';
// import '../firebase/firebase_options_qa.dart';

enum Env { dev, qa, prod }

class Environment {
  static Env get current {
    var envStringValue =
        const String.fromEnvironment('env', defaultValue: 'dev');
    return Env.values.where((e) => describeEnum(e) == envStringValue).first;
  }

//use "flutterfire configure" to generat new options file
  static FirebaseOptions get firebaseOptions {
    switch (current) {
      case Env.dev:
        return DefaultFirebaseOptionsDev.currentPlatform;
      case Env.qa:
        return DefaultFirebaseOptionsDev.currentPlatform;
      case Env.prod:
        return DefaultFirebaseOptionsDev.currentPlatform;
    }
  }
}
