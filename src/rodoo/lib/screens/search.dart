import 'package:flutter/material.dart';
import 'package:rodoo/screens/root.dart';
import 'package:rodoo/utils/constants.dart';

class Search extends StatefulWidget {
  static const String route = '/search';

  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 60,
          color: kPrimaryColor,
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 280,
                color: Colors.white,
                child: Theme(
                  data: ThemeData().copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: kPrimaryColor,
                        ),
                  ),
                  child: TextField(
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18,
                    ),
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      // top padding is different to align hint text in center
                      contentPadding: EdgeInsets.only(top: 10),
                      prefixIcon: Icon(Icons.search, size: 30),
                      prefixIconColor: Colors.white,
                      border: InputBorder.none,
                      hintText: 'Restaurant or location',
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Root.route);
                },
                child: const Text(
                  "cancel",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
