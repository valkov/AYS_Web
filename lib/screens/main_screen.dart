import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import 'error_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getTextAsync(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          EasyLoading.show();
          return Container();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const ErrorScreen();
          } else if (snapshot.hasData) {
            EasyLoading.showSuccess('Loaded');
            return Scaffold(
                body: Center(
                    child: Text(
              snapshot.data ?? '',
              style: TextStyle(fontSize: 40, color: primaryColor),
            )));
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

  Future<String> _getTextAsync() async {
    return Future.delayed(const Duration(seconds: 1), () => 'AYS');
  }
}
