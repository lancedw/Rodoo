import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ReserveTableScreen extends StatefulWidget {
  const ReserveTableScreen({Key? key}) : super(key: key);
  static const String route = '/reservetable';

  @override
  _ReserveTableState createState() => _ReserveTableState();
}

class _ReserveTableState extends State<ReserveTableScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Reserve table",
            style: appBarTextStyle,
          ),
        ),
        body: const Center(
          child: Text("Reserve"),
        ),
      ),
    );
  }
}
