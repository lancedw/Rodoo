import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rodo/utilities/date_helper.dart';
import 'package:rodo/utilities/constants.dart';
import 'dart:io' show Platform;

import 'package:rodo/widgets/resto_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int partySize = 2;
  var date = DateTime.utc(2021, 7, 15, 19, 00);

  @override
  Widget build(BuildContext context) {
    String parsedDate = date.toLocal().toString();
    String timeOfArrival = parsedDate.substring(10, 16);
    String day = parsedDate.substring(0, 10);
    if (date.isToday()) {
      day = "Today";
    }
    if (date.isTomorrow()) {
      day = "Tomorrow";
    }

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              backgroundColor: Colors.white,
              title: Padding(
                padding: Platform.isAndroid
                    ? EdgeInsets.only(top: 20)
                    : EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rodoo',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              bottom: PreferredSize(
                child: Container(
                  // top padding is to make sure that Rodo fully disappears
                  padding: EdgeInsets.only(top: 2, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person_outlined,
                            color: kPrimaryColor,
                          ),
                        ),
                        side: BorderSide(color: kPrimaryColor),
                        backgroundColor: Colors.white,
                        label: Text(
                          '2 • Now',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                preferredSize: Size.fromHeight(50),
              ),
              floating: true,
            )
          ],
          body: RestoWidget(),
        ),
      ),
    );
  }
}
