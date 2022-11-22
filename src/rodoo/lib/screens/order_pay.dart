import 'package:flutter/material.dart';

class OrderPay extends StatefulWidget {
  static const String route = '/orderpay';

  @override
  _OrderPayState createState() => _OrderPayState();
}

class _OrderPayState extends State<OrderPay> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          width: 400,
          height: 400,
          image: AssetImage('assets/icons/resto_image_android.png'),
        ),
      ),
    );
  }
}
