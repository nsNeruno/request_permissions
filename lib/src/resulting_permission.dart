part of request_permission;

class ResultingPermission {
  final Set<String> _permissions;
  final List<int> _grantResults;

  /// The requestCode used for the initial request.
  final int requestCode;

  const ResultingPermission._({
    required this.requestCode,
    required Set<String> permissions,
    required List<int> grantResults,
  })  : _permissions = permissions,
        _grantResults = grantResults;

  /// This map contains each requested permission, and
  /// whether it has been granted (`true`) or not (`false`).
  Map<String, bool> get grantedPermissions {
    final Map<String, bool> map = {};

    for (var i = 0; i < _permissions.length; i++) {
      if (i >= _grantResults.length) {
        // If there are more permissions than grantResults
        // then assume that the permissions have not been granted.
        map[_permissions.elementAt(i)] = false;
        continue;
      }

      map[_permissions.elementAt(i)] =
          RequestPermission.permissionGranted == _grantResults[i];
    }

    return map;
  }

  /// Check wheter a certain requested permission has
  /// been granted.
  bool isGranted(String permission) => grantedPermissions[permission] ?? false;
}
