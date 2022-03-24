import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '😢',
                style: textTheme.headline3?.copyWith(color: Colors.white),
              ),
              Text(
                "error title",
                style: textTheme.headline3?.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "error message",
                style: textTheme.headline5?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
