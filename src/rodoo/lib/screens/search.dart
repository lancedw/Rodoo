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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // left and right padding
          titleSpacing: 8,
          backgroundColor: kPrimaryColor,
          title: Container(
            height: 60,
            color: kPrimaryColor,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                      autofocus: true,
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                      ),
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        // top padding is different to align hint text in center
                        contentPadding: EdgeInsets.only(top: 6),
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
                    FocusManager.instance.primaryFocus?.unfocus();
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search,
                size: 50,
                color: Color(0xFF616161),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  "Search for your favorite restaurants or locations ...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
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
