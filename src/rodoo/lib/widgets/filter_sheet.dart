import 'package:flutter/material.dart';
import 'package:rodoo/utils/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  TextStyle subTitleStyle = const TextStyle(
    fontSize: 15,
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold,
  );
  String sortValue = "Popularity";
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
                "Filter",
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
          const SizedBox(
            height: 12,
          ),
          Text(
            "Sort By",
            style: subTitleStyle,
          ),
          const SizedBox(height: 8),
          Center(
            child: DropdownButton2(
              isExpanded: true,
              // to hide underline, we use a dummy sized box as underline widget
              underline: const SizedBox(height: 0),
              iconEnabledColor: kPrimaryColor,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 22,
              buttonPadding: const EdgeInsets.only(right: 12),
              buttonDecoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              // itemPadding: EdgeInsets.zero,
              value: sortValue,
              items: <String>['Popularity', 'Price', 'Distance']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: generalTextStyle,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  sortValue = value!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Discovery radius",
            style: subTitleStyle,
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
          Text(
            "Price range",
            style: subTitleStyle,
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
          Text(
            "Cuisine",
            style: subTitleStyle,
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            children: ["Italian", "French", "Thai", "Japanese", "Chinese"]
                .map(
                    (value) => Column(children: [Text(value), const Divider()]))
                .toList(),
          ),
          const SizedBox(
            height: 12,
          ),
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
          )
        ],
      ),
    );
  }
}
