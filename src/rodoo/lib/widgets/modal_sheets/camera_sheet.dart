import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rodoo/widgets/ui_elements/scanner_square_icon.dart';

import '../../main.dart';

class CameraViewSheet extends StatefulWidget {
  const CameraViewSheet({Key? key}) : super(key: key);

  @override
  State<CameraViewSheet> createState() => _CameraViewSheetState();
}

class _CameraViewSheetState extends State<CameraViewSheet> {
  late CameraController controller;
  double radius = 16;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = CameraController(cameras[0], ResolutionPreset.max);
  //   controller.initialize().then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   }).catchError((Object e) {
  //     if (e is CameraException) {
  //       switch (e.code) {
  //         case 'CameraAccessDenied':
  //           print('User denied camera access.');
  //           break;
  //         default:
  //           print('Handle other errors.');
  //           break;
  //       }
  //     }
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      //TODO: clean up debug mode dummy. Camera doesn't work on emulator so we provide a dummy. If code is run in profile mode for deployment on physical device, the camera works fine
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            kDebugMode
                ? Image.asset(
                    "assets/images/cameradummy.jpeg",
                    fit: BoxFit.cover,
                  )
                : CameraPreview(controller),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        iconSize: 30,
                        padding: const EdgeInsets.all(18),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Text(
                    "Scan a QR code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                ScannerSquare(
                  iconDistance: MediaQuery.of(context).size.width * 0.7,
                  iconSize: 35,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// !controller.value.isInitialized
// ? const Center(
// child: Text("Camera Controller init failed"),
// )
// : CameraPreview(controller));
