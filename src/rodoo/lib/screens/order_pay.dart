import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:rodoo/utils/constants.dart';

class OrderPay extends StatefulWidget {
  static const String route = '/orderpay';

  @override
  _OrderPayState createState() => _OrderPayState();
}

class _OrderPayState extends State<OrderPay> {
  Transform generateCornerIcon(double angle) {
    return Transform.rotate(
      angle: angle * math.pi / 180,
      child: const Icon(
        Icons.arrow_back_ios_outlined,
        color: Colors.white,
        size: 70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image(
                  width: MediaQuery.of(context).size.width,
                  image: const AssetImage('assets/images/blurred.webp'),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        generateCornerIcon(45),
                        const SizedBox(width: 70),
                        generateCornerIcon(135),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                      child: Center(
                        child: Text(
                          "Tap to scan",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        generateCornerIcon(-45),
                        const SizedBox(width: 70),
                        generateCornerIcon(-135),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
