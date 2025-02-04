import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:livent/screens/account.dart';
import 'package:livent/screens/favorites.dart';
import 'package:livent/screens/notifications.dart';
import 'package:livent/screens/order-pay.dart';
import 'package:livent/screens/root.dart';
import 'package:livent/utils/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livent',
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: Root.route,
      routes: {
        Root.route: (context) => Root(),
        Favorites.route: (context) => Favorites(),
        OrderPay.route: (context) => OrderPay(),
        Notifications.route: (context) => Notifications(),
        Account.route: (context) => const Account(),
      },
    );
  }
}
