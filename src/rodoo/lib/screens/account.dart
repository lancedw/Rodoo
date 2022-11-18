import 'package:flutter/material.dart';

import '../utils/constants.dart';

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
      body: const Center(
        child: Text('*Login and registrations page*'),
      ),
    );
  }
}
