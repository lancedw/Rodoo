import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ReserveTableScreen extends StatefulWidget {
  const ReserveTableScreen({Key? key}) : super(key: key);
  static const String route = '/reservetable';

  @override
  _ReserveTableState createState() => _ReserveTableState();
}

class _ReserveTableState extends State<ReserveTableScreen> {
  int numberOfAttendees = 4;
  int selectedMeal = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Reserve table",
          style: appBarTextStyle,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: 0),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text("Who"),
                        SizedBox(
                          height: 200,
                          width: 100,
                          child: CupertinoPicker(
                            itemExtent: 32,
                            onSelectedItemChanged: (int value) {
                              setState(() {
                                numberOfAttendees = value;
                              });
                            },
                            children: [1, 2, 3, 4, 5, 6, 7, 8, 9]
                                .map((text) => Center(child: Text(text.toString())))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("When"),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: CupertinoPicker(
                            itemExtent: 32,
                            onSelectedItemChanged: (int value) {
                              setState(() {
                                selectedMeal = value;
                              });
                            },
                            children: ["Breakfast", "Lunch", "Dinner"]
                                .map((text) => Center(child: Text(text.toString())))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Image(
                    image: AssetImage(
                      "assets/images/resengo.png",
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 44,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  ),
                  onPressed: () {
                    //TODO: continue table booking flow -> time of reservation and account authentication
                  },
                  child: Text(
                    "Book!",
                    style: generalTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
