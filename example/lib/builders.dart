import 'package:flutter/material.dart';
import 'package:request_permission/request_permission.dart';

Widget buildSinglePermissionButtons(
  String permission, [
  int requestCode = RequestPermission.defaultRequestCode,
]) {
  final short = permission.substring(permission.lastIndexOf(".") + 1);

  return Container(
    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(children: [
      Text(short),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("Request"),
            onPressed: () {
              RequestPermission.instace.requestAndroidPermission(
                AndroidPermissions.accessBackgroundLocation,
                requestCode,
              );
            },
          ),
          const SizedBox(width: 6),
          ElevatedButton(
            child: const Text("Has"),
            onPressed: () {
              RequestPermission.instace
                  .hasAndroidPermission(
                      AndroidPermissions.accessBackgroundLocation)
                  .then((value) {
                print("*********************HAS*********************");
                print("$short: $value\n");
                print("\n\n*********************HAS*********************");
              });
            },
          ),
        ],
      ),
    ]),
  );
}

Widget buildMultiplePermissionButtons(
  Set<String> permissions, [
  int requestCode = RequestPermission.defaultRequestCode,
]) {
  final short =
      permissions.map((e) => e.substring(e.lastIndexOf(".") + 1)).toSet();

  return Container(
    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(children: [
      for (final permission in short) Text(permission),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("Request"),
            onPressed: () {
              RequestPermission.instace.requestMultipleAndroidPermissions(
                permissions,
                requestCode,
              );
            },
          ),
          const SizedBox(width: 6),
          ElevatedButton(
            child: const Text("Has"),
            onPressed: () {
              RequestPermission.instace
                  .hasAndroidPermissions(permissions)
                  .then((value) {
                print("*********************HAS*********************");
                value.forEach((key, value) {
                  print("$key: $value\n");
                });
                print("\n\n*********************HAS*********************");
              });
            },
          ),
        ],
      ),
    ]),
  );
}
