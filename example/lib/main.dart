import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:request_permission/request_permission.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Tries to only allow Portrait mode, if an Error occures
  //it launches anyway but with Portrait and landscape
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).whenComplete(() {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String results;

  String permission;
  List<String> permissions;

  @override
  void initState() {
    super.initState();
    results = "Empty";

    permission = "android.permission.CAMERA";
    permissions = [
      permission,
      "android.permission.CALL_PHONE",
    ];

    RequestPermission.instace.results.listen((event) {
      setState(() {
        results = """
        permissions: ${event.permissions}
        requestCode: ${event.requestCode}
        grantResults: ${event.grantResults}
        """;
      });
      print("\n$results\n-----------------------------------\n");
    });

    RequestPermission.instace.setLogLevel(LogLevel.error);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text("request single"),
                onPressed: () {
                  RequestPermission.instace
                      .requestAndroidPermission(100, permission);
                },
              ),
              RaisedButton(
                child: Text("request multiple"),
                onPressed: () async {
                  await RequestPermission.instace
                      .requestMultipleAndroidPermissions(101, permissions);
                },
              ),
              RaisedButton(
                child: Text("has"),
                onPressed: () async {
                  bool has = await RequestPermission.instace
                      .hasAndroidPermission(permission);
                  print("has: $has");
                },
              ),
              Text("Results: $results"),
            ],
          ),
        ),
      ),
    );
  }
}
