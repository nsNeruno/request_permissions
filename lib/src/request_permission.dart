part of '../request_permission.dart';

class RequestPermission {
  RequestPermission._() {
    _shouldRequestPermissionSystemAlertWindow = false;
    _requestCode = defaultRequestCode;
    _requestedPermissions = {};
    _isWaitingForResponseNotifier = ValueNotifier(false);

    _results = _eventChannel.receiveBroadcastStream().map((event) {
      final data = jsonDecode(event) as Map<String, Object>;
      return ResultingPermission._(
        requestCode: data["requestCode"] as int,
        permissions: (data["permissions"] as List).map((e) => "$e").toSet(),
        grantResults: (data["grantResults"] as List)
            .map((e) => int.parse("$e"))
            .toList(growable: false),
      );
    }).asBroadcastStream();

    results.listen((event) {
      if (_shouldRequestPermissionSystemAlertWindow) {
        _shouldRequestPermissionSystemAlertWindow = false;
        _requestPermissionSystemAlertWindow(_requestCode);
      }

      _requestedPermissions.removeAll(event.grantedPermissions.keys);
      _updateIsWaitingForResponseValue();
    });
  }

  static const int permissionGranted = 0;
  static const int permissionDenied = -1;

  /// If you decide to omit the requestCode, when calling
  /// [requestAndroidPermission] or [requestMultipleAndroidPermissions],
  /// then this one gets used.
  static const int defaultRequestCode = 1049;

  static RequestPermission? _instance;

  // ignore: prefer_constructors_over_static_methods
  static RequestPermission get instace => _instance ??= RequestPermission._();

  /// [_results] has to be saved as a variable, because if
  /// `asBroadcastStream()` gets called multiple
  /// times on a [Stream], then this results in only the last
  /// added listener working.
  ///
  /// [Additional Info](https://stackoverflow.com/questions/16491069/why-does-this-dart-broadcast-stream-not-accept-multiple-listen-calls)
  late final Stream<ResultingPermission> _results;

  late bool _shouldRequestPermissionSystemAlertWindow;
  late int _requestCode;
  late Set<String> _requestedPermissions;

  late final ValueNotifier<bool> _isWaitingForResponseNotifier;

  /// Whether this app is currently waiting for a response
  /// from the user (`true`), or not (`false`).
  ValueListenable<bool> get isWaitingForResponse =>
      _isWaitingForResponseNotifier;

  /// After using [requestAndroidPermission] or
  /// [requestMultipleAndroidPermissions], you can listen to this
  /// `BroadcastStream`, to detect when the user makes his choice, whether
  /// he wants to grant your app the requested permisson/s or not.
  Stream<ResultingPermission> get results => _results;

  void _updateIsWaitingForResponseValue() {
    _isWaitingForResponseNotifier.value = _requestedPermissions.isNotEmpty;
  }

  /// The permission [AndroidPermissions.systemAlertWindow] has to
  /// be handled seperately.
  Future<void> _requestPermissionSystemAlertWindow(
          [int requestCode = defaultRequestCode]) =>
      _channel.invokeMethod("requestPermissionSystemAlertWindow", {
        "requestCode": requestCode,
      });

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

    await _channel.invokeMethod(
      "setLogLevel",
      <String, int>{"logLevel": levelCode},
    );
  }

  /// Calls [requestMultipleAndroidPermissions] to request
  /// a single [permission].
  ///
  /// `See` [requestMultipleAndroidPermissions] for more info.
  Future<void> requestAndroidPermission(
    String permission, [
    int requestCode = defaultRequestCode,
  ]) =>
      requestMultipleAndroidPermissions({permission}, requestCode);

  /// ## Description
  ///
  /// * Use this function to request a [Set] of [permissions].
  ///
  /// ---
  ///
  /// * If your app `already has a certain permission`, then access
  ///   for it will not be asked again.
  ///
  /// ---
  ///
  /// * [Native implementation](https://developer.android.com/reference/androidx/core/app/ActivityCompat#requestPermissions(android.app.Activity,%20java.lang.String[],%20int)).
  ///
  ///
  /// ## Parameters
  ///
  /// * [permissions]: A set of [String]s, where each [String]
  ///   is one of the constants in [AndroidPermissions].
  ///   [See all possible permissions](https://developer.android.com/reference/android/Manifest.permission).
  ///
  ///
  /// * [requestCode]: The requestCode for your action. This is the
  ///   requestCode you get, from [ResultingPermission], when
  ///   listening to [results].
  ///
  ///
  /// ## Return
  ///
  /// * Completes with a [Future.error], if [requestMultipleAndroidPermissions]
  ///   was called while [isWaitingForResponse] is `true`.
  Future<void> requestMultipleAndroidPermissions(
    Set<String> permissions, [
    int requestCode = defaultRequestCode,
  ]) async {
    if (isWaitingForResponse.value) return Future.error("""
Cannot request another permission, while still waiting for a
response from the user for the previously requested permissions.

previously requested:

$_requestedPermissions
""");

    List<String> ungrantedPermissions = [];

    for (final item in permissions) {
      if (!(await hasAndroidPermission(item))) ungrantedPermissions.add(item);
    }

    _requestedPermissions = ungrantedPermissions.toSet();
    _updateIsWaitingForResponseValue();

    // Remove duplicates
    ungrantedPermissions = _requestedPermissions.toList();

    // The permission [AndroidPermissions.systemAlertWindow] has
    // to be handled seperately.
    _shouldRequestPermissionSystemAlertWindow =
        ungrantedPermissions.remove(AndroidPermissions.systemAlertWindow);

    if (ungrantedPermissions.isNotEmpty) {
      await _channel.invokeMethod("requestPermissions", {
        "permissions": ungrantedPermissions,
        "requestCode": requestCode,
      });
      return;
    }

    // If [AndroidPermissions.systemAlertWindow] is the only
    // requested permission, then instantly request it.
    if (_shouldRequestPermissionSystemAlertWindow) {
      _shouldRequestPermissionSystemAlertWindow = false;
      await _requestPermissionSystemAlertWindow(requestCode);
    }
  }

  /// Check whether your app has a certain [permission].
  Future<bool> hasAndroidPermission(String permission) async =>
      await _channel.invokeMethod<bool>(
        "hasPermission",
        {"permission": permission},
      ) ??
      false;

  /// Calls [hasAndroidPermission] for every permission in [permissions].
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

  /// ## Description
  ///
  /// * Gets whether you should show UI with rationale for requesting a
  ///   permission. You should do this only if you do not have the permission
  ///   and the context in which the permission is requested does not clearly
  ///   communicate to the user what would be the benefit from granting this
  ///   permission.
  ///
  /// ---
  ///
  /// * For example, if you write a camera app, requesting the camera permission
  ///   would be expected by the user and no rationale for why it is requested
  ///   is needed. If however, the app needs location for tagging photos then a
  ///   non-tech savvy user may wonder how location is related to taking photos.
  ///   In this case you may choose to show UI with rationale of requesting this
  ///   permission.
  ///
  ///
  /// ## Parameters
  ///
  /// * **[permission]**:
  ///   A permission your app wants to request.
  ///
  ///
  /// ## Return
  ///
  /// * Whether you can show permission rationale UI.
  ///
  ///
  /// ## References
  ///
  /// [ActivityCompat#shouldShowRequestPermissionRationale](https://developer.android.com/reference/androidx/core/app/ActivityCompat#shouldShowRequestPermissionRationale(android.app.Activity,%20java.lang.String))
  Future<bool> shouldShowRequestPermissionRationale(String permission) async =>
      await _channel.invokeMethod<bool>(
        "shouldShowRequestPermissionRationale",
        {"permission": permission},
      ) ??
      false;
}

enum LogLevel {
  verbose,
  error,
  none,
}
