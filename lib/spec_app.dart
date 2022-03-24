import 'package:AYS/screens/error_screen.dart';
import 'package:AYS/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AYSApp extends StatefulWidget {
  const AYSApp({Key? key}) : super(key: key);

  @override
  State<AYSApp> createState() => _AYSAppState();
}

class _AYSAppState extends State<AYSApp> {
  get primaryColor => null;

  Locale getLocale() {
    return const Locale("en", "US");
  }

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      var inDebug = false;
      assert(() {
        inDebug = true;
        return true;
      }());

      // In debug mode, use the normal error widget which shows
      // the error message:
      if (inDebug) {
        return ErrorWidget(details.exception);
      }

      return const ErrorScreen();
    };

    return GetMaterialApp(
      title: "AYS",
      // translations: Languages(),
      // //locale: Get.deviceLocale,
      // locale: const Locale('en', 'US'),
      // fallbackLocale: const Locale("en", "US"),
      defaultTransition: Transition.native,
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
