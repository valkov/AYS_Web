import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import 'error_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late DatabaseReference _studentsRef;
  late StreamSubscription<DatabaseEvent> _studentsSubscription;
  bool initialized = false;
  var studentsMap = Map<String, dynamic>();
  var lastMessage = "";

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _studentsSubscription.cancel();
  }

  Future<void> init() async {
    _studentsRef = FirebaseDatabase.instance.ref('Students');

    final database = FirebaseDatabase.instance;

    database.setLoggingEnabled(false);

    if (!kIsWeb) {
      database.setPersistenceEnabled(true);
      database.setPersistenceCacheSizeBytes(10000000);
    }

    if (!kIsWeb) {
      await _studentsRef.keepSynced(true);
    }

    setState(() {
      initialized = true;
    });

    try {
      final counterSnapshot = await _studentsRef.get();

      print(
        'Connected to directly configured database and read '
        '${counterSnapshot.value}',
      );
    } catch (err) {
      print(err);
    }

    _studentsSubscription = _studentsRef.onValue.listen(
      (DatabaseEvent event) {
        setState(() {
          var map = event.snapshot.value as Map<String, dynamic>;
          for (var key in map.keys) {
            try {
              if (key == 'latestMessage') {
                lastMessage = map[key] as String;
              }

              var studentMap = map[key] as Map<String, dynamic>;
              var toBeEvaluated = studentMap["toBeEvaluated"] as bool;
              studentsMap.addAll({key: toBeEvaluated});
            } catch (err) {}
          }
          var a = event.snapshot.value;
          print("aha!");
        });
      },
      onError: (Object o) {
        //final error = o as FirebaseException;
        setState(() {
          //_error = error;
        });
      },
    );
  }

  Widget build(BuildContext context) {
    if (!initialized)
      return Center(child: Text("Loading...", style: TextStyle(fontSize: 50)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Yourself'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var studentName in studentsMap.keys)
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(studentName, style: TextStyle(fontSize: 50)),
                      Container(
                        height: 20,
                        width: 20,
                        color: studentsMap[studentName]
                            ? Colors.green
                            : Colors.red,
                      ),
                    ],
                  ))
              ],
            ),
            SizedBox(height: 150),
            Text(lastMessage,
                style: TextStyle(fontSize: 25, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
