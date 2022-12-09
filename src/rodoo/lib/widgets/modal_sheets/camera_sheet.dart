import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CameraViewSheet extends StatefulWidget {
  const CameraViewSheet({Key? key}) : super(key: key);

  @override
  State<CameraViewSheet> createState() => _CameraViewSheetState();
}

class _CameraViewSheetState extends State<CameraViewSheet> {

  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: MediaQuery.of(context).size.height * 0.70,
    //   padding: const EdgeInsets.all(16),
    //   decoration: const BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(10),
    //       topRight: Radius.circular(10),
    //     ),
    //   ),
    // );
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }
}
