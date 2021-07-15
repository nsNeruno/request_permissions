import 'package:flutter/material.dart';
import 'package:request_permission/request_permission.dart';

import 'builders.dart';

/// This Example showcases how to request the following permissions.
///
/// [AndroidPermissions.accessFineLocation]
/// [AndroidPermissions.accessCoarseLocation]
/// [AndroidPermissions.accessBackgroundLocation]
class ExampleLocationPermissions extends StatefulWidget {
  @override
  _ExampleLocationPermissionsState createState() =>
      _ExampleLocationPermissionsState();
}

class _ExampleLocationPermissionsState
    extends State<ExampleLocationPermissions> {
  late String results;
  late Set<String> prerequisites;

  @override
  void initState() {
    super.initState();
    results = "Empty";

    /// Before aquiring the permission [AndroidPermissions.accessBackgroundLocation],
    /// we have to get the users consent for the following [prerequisites].
    prerequisites = {
      AndroidPermissions.accessFineLocation,
      AndroidPermissions.accessCoarseLocation
    };

    RequestPermission.instace.results.listen((event) {
      setState(() {
        results = """requestCode: ${event.requestCode}
grantResults: ${event.grantResults}
""";

        event.permissions.forEach((element) {
          final permission = element.substring(element.lastIndexOf(".") + 1);
          results += "$permission: ${event.grantedPermissions[element]}\n";
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
}
