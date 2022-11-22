import 'package:flutter/material.dart';
import 'package:rodoo/widgets/buttons/rounded_button.dart';

import '../utils/constants.dart';
import 'login.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  static const String route = "/account";

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Account",
          style: appBarTextStyle,
        ),
      ),
      body: Center(
        child: RoundedLogRegButton(
          color: kPrimaryColor,
          buttonTitle: "Login",
          onPressed: () {
            Navigator.pushNamed(context, LoginPage.route);
          },
        ),
      ),
    );
  }
}
