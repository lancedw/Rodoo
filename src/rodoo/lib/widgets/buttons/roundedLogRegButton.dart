import 'package:flutter/material.dart';

class RoundedLogRegButton extends StatelessWidget {
  Color color;
  String buttonTitle;
  VoidCallback onPressed;

  RoundedLogRegButton(
      {required this.color,
      required this.buttonTitle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
