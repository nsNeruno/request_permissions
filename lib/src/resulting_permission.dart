part of request_permission;

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
        map[permissions.elementAt(i)] =
            RequestPermission.permissionGranted == grantResults[i];
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
