import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class RequestPermission {
  static const String _namespace =
      "com.u12ampere.request_permission.RequestPermissionPlugin";
  static const String _methodChannelId = _namespace + ".methods";
  static const String _eventChannelId = _namespace + ".events";

  static const MethodChannel _channel = MethodChannel(_methodChannelId);
  static const EventChannel _eventChannel = EventChannel(_eventChannelId);

  static RequestPermission _instance;

  RequestPermission._();

  static RequestPermission get instace => _instance ??= RequestPermission._();

  /// After using [requestAndroidPermission] or [requestMultipleAndroidPermissions],
  /// you can listen to this stream, to detect when the user
  /// makes his choice, wether he wants to grant
  /// your app the requested permisson/s or not.
  Stream<ResultingPermission> get results =>
      _eventChannel.receiveBroadcastStream().map((event) {
        final data = jsonDecode(event);
        return ResultingPermission._(
          requestCode: data["requestCode"] as int,
          permissions: (data["permissions"] as List)
              .map((e) => "$e")
              .toList(growable: false),
          grantResults: (data["grantResults"] as List)
              .map((e) => int.parse("$e"))
              .toList(growable: false),
        );
      }).asBroadcastStream();

  /// This function uses [requestMultipleAndroidPermissions] to request
  /// a single [permission].
  ///
  /// `See` [requestMultipleAndroidPermissions] `for more info.`
  Future<bool> requestAndroidPermission(
    int requestCode,
    String permission,
  ) async {
    return (await requestMultipleAndroidPermissions(requestCode, [permission]))
        .values
        .first;
  }

  /// ## Description
  ///
  /// * Use this function to request a list of [permissions].
  ///
  ///
  /// * If your app `already has a certain permission`, then access
  ///   for it will not be asked again.
  ///
  ///
  /// * [Native implementation](https://developer.android.com/reference/androidx/core/app/ActivityCompat#requestPermissions(android.app.Activity,%20java.lang.String[],%20int)).
  ///
  ///
  /// ## Paramters
  ///
  /// * [permissions]: A list of strings, which are permissions,
  ///   that you want to get granted by the user.
  ///   [See all possible permissions](https://developer.android.com/reference/android/Manifest.permission).
  ///
  ///
  /// * [requestCode]: The requestCode for your action. The
  ///   [requestCode], from [ResultingPermission], you get, when listening to [results],
  ///   is the one you set here.
  ///
  ///
  /// ## Returns
  ///
  /// * This function returns a [Map], that contains each permission you requested
  ///   as a key and wheter your app already has the permission or not.
  ///   If your app already has the permission, then that qualifies as `true` and
  ///   the user will not get asked for it again.
  Future<Map<String, bool>> requestMultipleAndroidPermissions(
    int requestCode,
    List<String> permissions,
  ) async {
    assert(requestCode != null);
    assert(permissions != null);
    return Map.from(
      await _channel.invokeMethod("requestPermissions", <String, Object>{
        "permissions": permissions,
        "requestCode": requestCode,
      }),
    );
  }

  /// Check wether your app has a certain [permission].
  Future<bool> hasAndroidPermission(String permission) async =>
      await _channel.invokeMethod("hasPermission", <String, Object>{
        "permission": permission,
      });

  /// The logLevel defaults to [LogLevel.verbose].
  Future<void> setLogLevel(LogLevel logLevel) async => await _channel
      .invokeMethod("setLogLevel", <String, int>{"logLevel": logLevel.index});
}

class ResultingPermission {
  final int requestCode;
  final List<String> permissions;
  final List<int> grantResults;

  const ResultingPermission._({
    this.requestCode,
    this.permissions,
    this.grantResults,
  });

  /// A map that contains each permission from [permissions],
  /// and wheter it has been granted or not.
  ///
  /// The permission being granted corresponds to `true`.
  Map<String, bool> get grantedPermissions {
    Map<String, bool> map = {};
    for (var i = 0; i < permissions.length; i++) {
      if (i < grantResults.length) {
        map[permissions[i]] = grantResults[i] == 0;
      } else {
        // If there are more permissions than grantResults
        // then assume that they are not granted
        map[permissions[i]] = false;
      }
    }
    return map;
  }

  /// Check wheter a certain requested [permission] has
  /// been granted.
  ///
  /// The permission beiing granted corresponds to `true`.
  bool isGranted(String permission) {
    assert(permissions.contains(permission));
    return grantedPermissions[permission];
  }
}

enum LogLevel {
  verbose,
  error,
  none,
}
