import 'package:flutter/material.dart';
import 'package:rodoo/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class WhoWhenSheet extends StatefulWidget {
  const WhoWhenSheet({Key? key}) : super(key: key);

  @override
  State<WhoWhenSheet> createState() => _WhoWhenSheetState();
}

class _WhoWhenSheetState extends State<WhoWhenSheet> {
  TextStyle subTitleStyle = const TextStyle(
    fontSize: 15,
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold,
  );
  int numberOfAttendees = 2;
  int selectedMeal = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Who & What",
                  style: restoNameTextStyle,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
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
                                .map((text) =>
                                    Center(child: Text(text.toString())))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("What"),
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
                                .map((text) =>
                                    Center(child: Text(text.toString())))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Apply filters",
                  style: generalTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
