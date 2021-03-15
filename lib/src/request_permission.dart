import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'android_permissions.dart';

class RequestPermission {
  static const String _namespace =
      "com.twelve_ampere.request_permission.RequestPermissionPlugin";
  static const String _methodChannelId = "$_namespace.methods";
  static const String _eventChannelId = "$_namespace.events";

  static const MethodChannel _channel = MethodChannel(_methodChannelId);
  static const EventChannel _eventChannel = EventChannel(_eventChannelId);

  static RequestPermission? _instance;

  // ignore: prefer_constructors_over_static_methods
  static RequestPermission get instace => _instance ??= RequestPermission._();

  /// If you decide to omit the [requestCode], when calling
  /// [requestAndroidPermission] or [requestMultipleAndroidPermissions],
  /// then this one gets used.
  static const int defaultRequestCode = 1049;

  late bool _hasPermissionSystemAlertWindow;
  late int _requestCode;
  late Set<String> _requestedPermissions;

  /// [_results] has to be saved as a variable, because if
  /// `asBroadcastStream()` gets called multiple
  /// times on a [Stream], then this results in only the last
  /// added listener working.
  ///
  /// [Additional Info](https://stackoverflow.com/questions/16491069/why-does-this-dart-broadcast-stream-not-accept-multiple-listen-calls)
  late Stream<ResultingPermission> _results;

  RequestPermission._() {
    _hasPermissionSystemAlertWindow = false;
    _requestCode = defaultRequestCode;
    _requestedPermissions = {};

    _results = _eventChannel.receiveBroadcastStream().map((event) {
      final data = jsonDecode(event);
      return ResultingPermission._(
        requestCode: data["requestCode"] as int,
        permissions: (data["permissions"] as List).map((e) => "$e").toSet(),
        grantResults: (data["grantResults"] as List)
            .map((e) => int.parse("$e"))
            .toList(growable: false),
      );
    }).asBroadcastStream();

    results.listen((event) {
      if (_hasPermissionSystemAlertWindow) {
        _requestPermissionSystemAlertWindow(_requestCode);
        _hasPermissionSystemAlertWindow = false;
      }
      _requestedPermissions.removeAll(event.grantedPermissions.keys);
    });
  }

  /// Wether this app is currently waiting for a response from the user
  /// (`true`), or not (`false`).
  bool get isWaitingForResponse => _requestedPermissions.isNotEmpty;

  /// After using [requestAndroidPermission] or [requestMultipleAndroidPermissions],
  /// you can listen to this `BroadcastStream`, to detect when the user
  /// makes his choice, wether he wants to grant
  /// your app the requested permisson/s or not.
  Stream<ResultingPermission> get results => _results;

  /// This function uses [requestMultipleAndroidPermissions] to request
  /// a single [permission].
  ///
  /// `See` [requestMultipleAndroidPermissions] `for more info.`
  Future<void> requestAndroidPermission(
    String permission, [
    int requestCode = defaultRequestCode,
  ]) async =>
      requestMultipleAndroidPermissions({permission}, requestCode);

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
  /// * [permissions]: A set of strings, which are permissions,
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
  Future<void> requestMultipleAndroidPermissions(
    Set<String> permissions, [
    int requestCode = defaultRequestCode,
  ]) async {
    if (isWaitingForResponse) {
      print("""
*********************************************************
RequestPermission: Can not request another permission, while
still waiting for a response from the user for the previously
requested permissions.

previously requested: $_requestedPermissions

*********************************************************
    """);
    } else {
      final List<String> ungrantedPermissionsAsList = [];

      for (final item in permissions) {
        if (!(await hasAndroidPermission(item))) {
          ungrantedPermissionsAsList.add(item);
        }
      }

      _requestedPermissions = ungrantedPermissionsAsList.toSet();

      /// The permission [AndroidPermissions.systemAlertWindow] has
      /// to be handled seperately.
      _hasPermissionSystemAlertWindow = ungrantedPermissionsAsList
          .remove(AndroidPermissions.systemAlertWindow);

      if (ungrantedPermissionsAsList.isNotEmpty) {
        await _channel.invokeMethod("requestPermissions", <String, Object>{
          "permissions": ungrantedPermissionsAsList,
          "requestCode": requestCode,
        });
      } else if (_hasPermissionSystemAlertWindow) {
        await _requestPermissionSystemAlertWindow(requestCode);
        _hasPermissionSystemAlertWindow = false;
      }
    }
  }

  /// The permission [AndroidPermissions.system_alert_window] has to
  /// be handled seperately.
  ///
  /// Returns wether your app has already been granted the permission (`true`),
  /// or if it has to be requested (`false`);
  Future<void> _requestPermissionSystemAlertWindow(
          [int requestCode = defaultRequestCode]) async =>
      _channel.invokeMethod("requestPermissionSystemAlertWindow", {
        "requestCode": requestCode,
      });

  /// Check wether your app has a certain [permission].
  Future<bool> hasAndroidPermission(String permission) async =>
      await _channel.invokeMethod("hasPermission", <String, Object>{
        "permission": permission,
      });

  /// Calls [hasAndroidPermission] on every permission in [permissions].
  Future<Map<String, bool>> hasAndroidPermissions(
      Set<String> permissions) async {
    final results = Map<String, bool>.fromIterable(
      permissions,
      key: (element) => element,
      value: (element) => false,
    );

    for (final permission in permissions)
      results[permission] = await hasAndroidPermission(permission);

    return results;
  }

  /// The logLevel defaults to [LogLevel.verbose].
  Future<void> setLogLevel(LogLevel logLevel) async {
    int levelCode = 8;

    switch (logLevel) {
      case LogLevel.verbose:
        levelCode = 2;
        break;
      case LogLevel.error:
        levelCode = 6;
        break;
      case LogLevel.none:
        levelCode = 8;
        break;
      default:
        levelCode = 8;
    }

    await _channel
        .invokeMethod("setLogLevel", <String, int>{"logLevel": levelCode});
  }
}

class ResultingPermission {
  final int requestCode;
  final Set<String> permissions;
  final List<int> grantResults;

  const ResultingPermission._({
    required this.requestCode,
    required this.permissions,
    required this.grantResults,
  });

  /// A map that contains each permission from [permissions],
  /// and wheter it has been granted or not.
  ///
  /// The permission being granted corresponds to `true`.
  Map<String, bool> get grantedPermissions {
    final Map<String, bool> map = {};
    for (var i = 0; i < permissions.length; i++) {
      if (i < grantResults.length) {
        map[permissions.elementAt(i)] = grantResults[i] == 0;
      } else {
        // If there are more permissions than grantResults
        // then assume that they are not granted
        map[permissions.elementAt(i)] = false;
      }
    }
    return map;
  }

  /// Check wheter a certain requested [permission] has
  /// been granted.
  ///
  /// The permission beiing granted corresponds to `true`.
  bool isGranted(String permission) => grantedPermissions[permission] ?? false;
}

enum LogLevel {
  verbose,
  error,
  none,
}
