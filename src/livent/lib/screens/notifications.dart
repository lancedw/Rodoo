import 'package:flutter/material.dart';
import 'package:livent/utils/constants.dart';

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
        title: const Text(
          "Notifications",
          style: appBarTextStyle,
        ),
      ),
    );
  }
}
