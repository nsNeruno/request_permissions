import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:request_permission/request_permission.dart';

import 'other_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Tries to only allow Portrait mode, if an Error occures
  //it launches anyway but with Portrait and landscape
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).whenComplete(() {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String results;

  String permission;
  Set<String> permissions;

  RequestPermission requestPermission;

  @override
  void initState() {
    super.initState();
    results = "Empty";

    permission = "android.permission.CAMERA";
    permissions = {
      permission,
      "android.permission.CALL_PHONE",
      "android.permission.SYSTEM_ALERT_WINDOW"
    };

    requestPermission = RequestPermission.instace;

    requestPermission.results.listen((event) {
      setState(() {
        results = """
        permissions: ${event.permissions}
        requestCode: ${event.requestCode}
        grantResults: ${event.grantResults}
        
        grantedPermissions: ${event.grantedPermissions}
        """;
      });
    });

    requestPermission.setLogLevel(LogLevel.none);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text("request single"),
                onPressed: () {
                  requestPermission.requestAndroidPermission(permission, 100);
                },
              ),
              ElevatedButton(
                child: const Text("request window"),
                onPressed: () {
                  requestPermission.requestAndroidPermission(
                    "android.permission.SYSTEM_ALERT_WINDOW",
                    40,
                  );
                },
              ),
              ElevatedButton(
                child: const Text("request multiple"),
                onPressed: () {
                  requestPermission.requestMultipleAndroidPermissions(
                    permissions,
                    101,
                  );
                },
              ),
              ElevatedButton(
                child: const Text("has"),
                onPressed: () async {
                  final bool has =
                      await requestPermission.hasAndroidPermission(permission);
                  print("""
                  permission: $permission
                  hasPermission: $has
                  """);
                },
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.amber[200],
                ),
                padding: const EdgeInsets.all(6),
                child: Text(
                  results,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              OtherWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
