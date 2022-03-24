import 'dart:async';
//import 'dart:ffi';

import 'package:AYS/spec_app.dart';
import 'package:AYS/utils/environment.dart';
import 'package:AYS/utils/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
  // Get.addTranslations({"en_US": enUS});

  _setupCrashlytics();

  runZonedGuarded(() {
    runApp(const AYSApp());
  }, (error, stackTrace) {
    logger.e('runZonedGuarded: Caught error in my root zone: ', error);
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
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

void _setupCrashlytics() async {
  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }
}
