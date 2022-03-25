import 'dart:async';
//import 'dart:ffi';

import 'package:AYS/ays_app.dart';
import 'package:AYS/utils/environment.dart';
import 'package:AYS/utils/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

void main() async {
  _envSetup();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: Environment.firebaseOptions);

  //localisation
  var defaultLocale = const Locale('en', 'US');
  Get.fallbackLocale = defaultLocale;
  Get.updateLocale(Get.deviceLocale ?? defaultLocale);

  runZonedGuarded(() {
    runApp(const AYSApp());
  }, (error, stackTrace) {
    logger.e('runZonedGuarded: Caught error in my root zone: ', error);
  });
}

void _envSetup() {
  if (kIsWeb) {
    return;
  }
  switch (Environment.current) {
    case Env.dev:
      Logger.level = Level.verbose;
      break;
    case Env.qa:
      Logger.level = Level.verbose;
      break;
    case Env.prod:
      Logger.level = Level.error;
      break;
  }
}
