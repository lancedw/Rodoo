import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rodoo/utils/constants.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  double distanceValue = 10;
  List<bool> price = [false, true, false];

  List<Text> generateButtons(List<bool> price) {
    List<Text> buttons = [];

    for (int i = 0; i < price.length; i += 1) {
      Text item = Text(
        "\$" * (i + 1),
        style: TextStyle(
          fontSize: price[i] ? 22 : 18,
          fontWeight: price[i] ? FontWeight.bold : null,
        ),
      );
      buttons.add(item);
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filter options",
                style: restoNameTextStyle,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Maximum driving distance",
            style: generalBoldTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${distanceValue.toInt().toString()} km",
                style: generalTextStyle,
              ),
              Slider(
                activeColor: kPrimaryColor,
                label: "${distanceValue.toInt().toString()} km",
                min: 0,
                max: 100,
                divisions: 50,
                value: distanceValue,
                onChanged: (double val) {
                  setState(() {
                    distanceValue = val;
                  });
                },
              ),
            ],
          ),
          const Text(
            "Price range",
            style: generalBoldTextStyle,
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: ToggleButtons(
              isSelected: price,
              selectedColor: kPrimaryColor,
              fillColor: Colors.white,
              splashColor: Colors.white,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < price.length; i += 1) {
                    price[i] = false;
                  }
                  price[index] = true;
                });
              },
              children: generateButtons(price),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Food styles",
            style: generalBoldTextStyle,
          ),
        ],
      ),
    );
  }
}
