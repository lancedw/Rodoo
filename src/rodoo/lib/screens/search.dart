import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rodoo/utils/constants.dart';

class Search extends StatefulWidget {
  static const String route = '/favorites';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Search",
          style: appBarTextStyle,
        ),
      ),
    );
  }
}
