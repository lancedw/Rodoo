import 'package:flutter/material.dart';
import 'package:rodo/screens/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rodo/utilities/route_generator.dart';
import 'package:rodo/utilities/theme.dart';
import 'widgets/dismiss_keyboard_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Rodo());
}

// Rodo main function has to be a stateless widget to enable hot reload
class Rodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        initialRoute: Root.route,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
