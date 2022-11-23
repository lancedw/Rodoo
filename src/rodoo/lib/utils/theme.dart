import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

final ThemeData theme = ThemeData(
  primaryColorLight: kPrimaryColor,
  secondaryHeaderColor: CupertinoColors.black,
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 20.0,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          32.0,
        ),
      ),
    ),
    // enabledBorder: OutlineInputBorder(
    //   borderSide: BorderSide(
    //     color: kPrimaryColor,
    //     width: 1.0,
    //   ),
    //   borderRadius: BorderRadius.all(
    //     Radius.circular(32.0),
    //   ),
    // ),
    // focusedBorder: OutlineInputBorder(
    //   borderSide: BorderSide(
    //     color: kPrimaryColor,
    //     width: 2.0,
    //   ),
    //   borderRadius: BorderRadius.all(
    //     Radius.circular(32.0),
    //   ),
    // ),
  ),
  iconTheme: const IconThemeData(
    color: kPrimaryColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: CupertinoColors.white,
    elevation: 0,
    titleTextStyle: appBarTextStyle,
    iconTheme: IconThemeData(
      color: kPrimaryColor,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kPrimaryColor,
  ),
  backgroundColor: Colors.white,
  primaryColor: kPrimaryColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedIconTheme: IconThemeData(
      color: kPrimaryColor,
    ),
    unselectedIconTheme: IconThemeData(
      color: kPrimaryColor,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: kPrimaryColor,
  ),
);
