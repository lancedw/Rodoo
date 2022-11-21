import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rodo/utilities/constants.dart';

class Favorites extends StatefulWidget {
  static const String route = '/favorites';

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Favorites",
          style: appBarTextStyle,
        ),
      ),
    );
  }
}
