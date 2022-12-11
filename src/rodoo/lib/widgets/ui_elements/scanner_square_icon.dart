import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScannerSquare extends StatelessWidget {
  final bool centerText;
  final String innerText;
  final double iconSize;
  final double iconDistance;

  const ScannerSquare(
      {required this.iconSize,
      required this.iconDistance,
      this.centerText = false,
      this.innerText = "",
      Key? key})
      : super(key: key);

  Transform generateCornerIcon(double angle) {
    return Transform.rotate(
      angle: angle * math.pi / 180,
      child: Icon(
        Icons.arrow_back_ios_outlined,
        color: Colors.white,
        size: iconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            generateCornerIcon(45),
            SizedBox(width: iconDistance),
            generateCornerIcon(135),
          ],
        ),
        SizedBox(
          height: iconDistance,
          child: centerText
              ? Center(
                  child: Text(
                    innerText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                )
              : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            generateCornerIcon(-45),
            SizedBox(width: iconDistance),
            generateCornerIcon(-135),
          ],
        ),
      ],
    );
  }
}
