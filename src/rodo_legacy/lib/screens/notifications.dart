import 'package:flutter/material.dart';
import 'package:rodo/utilities/constants.dart';

class Notifications extends StatefulWidget {
  static const String route = '/notifications';

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Notifications",
          style: appBarTextStyle,
        ),
      ),
    );
  }
}
