import 'package:flutter/material.dart';
import 'package:rodoo/utils/date_helper.dart';
import 'package:rodoo/utils/constants.dart';
import 'package:rodoo/widgets/modal_sheets/date_sheet.dart';
import 'package:rodoo/widgets/modal_sheets/filter_sheet.dart';
import 'package:rodoo/widgets/home_listview.dart';
import 'package:rodoo/widgets/modal_sheets/who_what_sheet.dart';
import 'dart:io' show Platform;
import 'account.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const String route = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int partySize = 2;
  int mealType = 2; //0:breakfast, 1:lunch, 2:diner
  List<String> mealTypes = ["Breakfast", "Lunch", "Diner"];
  late DateTime date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            backgroundColor: Colors.white,
            title: Padding(
              padding: Platform.isAndroid
                  ? const EdgeInsets.only(top: 20)
                  : const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rodoo',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person_outlined,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Account.route);
                    },
                  )
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                // top padding is to make sure that Rodoo fully disappears
                padding: const EdgeInsets.only(top: 2, left: 20, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => WhoWhenSheet(
                                numberOfAttendees: partySize,
                                selectedMeal: mealType,
                              ),
                            )
                                .then((data) => setState(() {
                                      partySize = data[0];
                                      mealType = data[1];
                                    }))
                                .onError((error, stackTrace) => null);
                          },
                          child: Chip(
                            avatar: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person_outlined,
                                color: kPrimaryColor,
                              ),
                            ),
                            side: const BorderSide(color: kPrimaryColor),
                            backgroundColor: Colors.white,
                            label: Text(
                              '$partySize • ${mealTypes[mealType]}',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const DateSheet(),
                            );
                          },
                          child: const Chip(
                            avatar: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            side: BorderSide(color: kPrimaryColor),
                            backgroundColor: Colors.white,
                            labelPadding:
                                EdgeInsets.only(left: 10.0, right: 8.0),
                            label: Text(
                              'Now',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        color: kPrimaryColor,
                        size: 32,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const FilterSheet(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            floating: true,
          )
        ],
        body: const RestoWidget(),
      ),
    );
  }
}
