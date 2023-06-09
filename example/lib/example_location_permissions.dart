import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:request_permission/request_permission.dart';

import 'builders.dart';

/// This example showcases how to request the following permissions.
///
/// [AndroidPermissions.accessFineLocation]
/// [AndroidPermissions.accessCoarseLocation]
/// [AndroidPermissions.accessBackgroundLocation]
class ExampleLocationPermissions extends StatefulWidget {
  const ExampleLocationPermissions({Key? key}) : super(key: key);

  @override
  _ExampleLocationPermissionsState createState() =>
      _ExampleLocationPermissionsState();
}

class _ExampleLocationPermissionsState
    extends State<ExampleLocationPermissions> {
  late String results;
  late Set<String> prerequisites;

  void waitingForResponseListener() {
    print("\n\nisWaitingForResponse: "
        "${RequestPermission.instace.isWaitingForResponse.value}\n\n");
  }

  @override
  void initState() {
    super.initState();
    results = "Empty";

    /// Before aquiring the permission
    /// [AndroidPermissions.accessBackgroundLocation], we have to get the
    /// users consent for the following [prerequisites].
    prerequisites = {
      AndroidPermissions.accessFineLocation,
      AndroidPermissions.accessCoarseLocation
    };

    RequestPermission.instace
      ..isWaitingForResponse.addListener(waitingForResponseListener)
      ..results.listen((event) {
        setState(() {
          results = """
requestCode: ${event.requestCode}
""";

          event.grantedPermissions.forEach((permission, isGranted) {
            results += "$permission: $isGranted\n";
          });
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSinglePermissionButtons(
                AndroidPermissions.accessBackgroundLocation,
              ),
              const SizedBox(height: 15),

              /// This has to be granted before requesting
              /// [AndroidPermissions.accessBackgroundLocation]
              buildMultiplePermissionButtons(prerequisites),
              const SizedBox(height: 15),

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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('results', results))
      ..add(IterableProperty<String>('prerequisites', prerequisites));
  }
}
