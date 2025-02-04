import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rodoo/screens/account.dart';
import 'package:rodoo/screens/login.dart';
import 'package:rodoo/screens/reserve_table.dart';
import 'package:rodoo/screens/search.dart';
import 'package:rodoo/screens/order_pay.dart';
import 'package:rodoo/root.dart';
import 'package:rodoo/utils/theme.dart';
import 'firebase_options.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rodoo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: Root.route,
      routes: {
        Root.route: (context) => const Root(),
        Search.route: (context) => const Search(),
        OrderPay.route: (context) => const OrderPay(),
        Account.route: (context) => const Account(),
        LoginPage.route: (context) => const LoginPage(),
        ReserveTableScreen.route: (context) => const ReserveTableScreen(),
      },
    );
  }
}
