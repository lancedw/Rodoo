import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color rodooBlue = Color(0xFF00BFFF);
const Color rodooRose = Color(0xFFFB9FD6);
const Color rodooGrey = Color(0xFF616161);

const Color kPrimaryColor = rodooRose;
const Color kSecondaryColor = rodooGrey;

const kDebugMode = true;

const String assetName = 'assets/icons/RestoIcon.svg';
final Widget restoIconSmall = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Resto Icon Small',
  width: 40,
  height: 40,
);

final Widget restoIconBig = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Resto Icon Big',
  width: 50,
  height: 50,
);

const textFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(
    color: Colors.grey,
    fontFamily: 'Montserrat',
  ),
  contentPadding: EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 20.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kPrimaryColor,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kPrimaryColor,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const appBarTextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 23,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const restoNameTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const ratingTextStyle = TextStyle(
  fontSize: 15,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const generalTextStyle = TextStyle(
  fontFamily: 'Montserrat',
);

const generalBoldTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
