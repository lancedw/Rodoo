import 'package:flutter/material.dart';
import 'package:rodoo/widgets/modal_sheets/camera_sheet.dart';
import 'package:rodoo/widgets/ui_elements/scanner_square_icon.dart';

class OrderPay extends StatefulWidget {
  static const String route = '/orderpay';

  const OrderPay({Key? key}) : super(key: key);

  @override
  _OrderPayState createState() => _OrderPayState();
}

class _OrderPayState extends State<OrderPay> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const CameraViewSheet(),
                );
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image(
                    width: MediaQuery.of(context).size.width,
                    image: const AssetImage('assets/images/blurred.webp'),
                  ),
                  const ScannerSquare(
                    iconSize: 70,
                    iconDistance: 70,
                    innerText: "Tap to scan QR code",
                    centerText: true,
                  )
                ],
              ),
            ),
            const Center(
              child: Text("TODO"),
            )
          ],
        ),
      ),
    );
  }
}
