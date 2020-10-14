import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
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

  /// After using [requestAndroidPermission], you can listen to this stream,
  /// to detect when the user makes his choice, wether he wants to grant
  /// your app the [RequestablePermission] or not.
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

  /// Use this function to request a [RequestablePermission],
  /// if your app `already has the permission` and [checkIfAlreadyHas] is `true`
  /// then nothing happens and `true` gets returned, else `false`.
  ///
  /// if [checkIfAlreadyHas] is `false` then the app tries to request
  /// the permission, even if it already has it.
  ///
  /// If `false` got returned you can use [results] to listen
  /// for the event, when the user makes his final choice.
  Future<bool> requestAndroidPermission(
    int requestCode,
    String permission, [
    bool checkIfAlreadyHas = true,
  ]) async {
    assert(requestCode != null);
    assert(permission != null);
    return await _channel
        .invokeMethod("requestAndroidPermission", <String, Object>{
      "permission": permission,
      "requestCode": requestCode,
      "checkIfAlreadyHas": checkIfAlreadyHas,
    });
  }

  // TODO: Docs
  Future<Map<String, bool>> requestMultipleAndroidPermissions(
    int requestCode,
    List<String> permissions,
  ) async {
    assert(requestCode != null);
    assert(permissions != null);
    return Map.from(
      await _channel
          .invokeMethod("requestMultipleAndroidPermissions", <String, Object>{
        "permissions": permissions,
        "requestCode": requestCode,
      }),
    );
  }

  /// Check wether your app has a certain [permission].
  Future<bool> hasAndroidPermission(String permission) async =>
      await _channel.invokeMethod("hasAndroidPermission", <String, Object>{
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
}

enum LogLevel {
  verbose,
  error,
  none,
}
