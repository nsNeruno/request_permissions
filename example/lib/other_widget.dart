import 'package:flutter/material.dart';
import 'package:request_permission/request_permission.dart';

class OtherWidget extends StatefulWidget {
  @override
  _OtherWidgetState createState() => _OtherWidgetState();
}

class _OtherWidgetState extends State<OtherWidget> {
  String txt;

  @override
  void initState() {
    super.initState();
    txt = "OtherWidget";
    RequestPermission.instace.results.listen((event) {
      setState(() {
        txt = event.permissions.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Text(txt),
    );
  }
}
