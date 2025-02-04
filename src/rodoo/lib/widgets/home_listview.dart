import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rodoo/dao/fire_storage.dart';
import 'package:rodoo/screens/detailed_restaurant.dart';
import 'package:rodoo/utils/constants.dart';
import 'package:rodoo/widgets/buttons/icon_togglebutton.dart';

class RestoWidget extends StatefulWidget {
  const RestoWidget({Key? key}) : super(key: key);

  @override
  State<RestoWidget> createState() => _RestoWidgetState();
}

class _RestoWidgetState extends State<RestoWidget> {
  Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('restaurants').snapshots();

  @override
  Widget build(BuildContext context) {

    Future<void> pullRefresh() async {
      setState(() {
        _usersStream =
            FirebaseFirestore.instance.collection('restaurants').snapshots();
      });
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong trying to build firestore stream: ${snapshot.error}',
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }

        return RefreshIndicator(
          //TODO: style refresh indicator (i.e. https://pub.dev/packages/custom_refresh_indicator)
          onRefresh: pullRefresh,
          backgroundColor: Colors.white,
          color: kPrimaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailedRestaurant(
                        restaurantData: data,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder<Image>(
                          future: FireStorageService.getImage(
                            context,
                            //TODO: fix file type issue -> jpg, jpeg, png, ...
                            "${data['image_name']}1.jpeg",
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: snapshot.data,
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text("Error loading image"),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    style: restoNameTextStyle,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 20,
                                  ),
                                  Text(
                                    data['rating'].toString(),
                                    style: ratingTextStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Transform.rotate(
                                    angle: 0.75,
                                    child: const Icon(
                                      Icons.navigation_rounded,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    // data['Address'].join(' • '),
                                    // "${data['street']} ${data['street_number']}",
                                    "${data['city']} - ${data['distance']}",
                                    style: generalTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconToggleButton(
                                activeIcon: const Icon(Icons.favorite),
                                nonActiveIcon: const Icon(Icons.favorite_border),
                                iconSize: 33,
                                isEnabled: true,
                                selected: data["is_favorite"],
                                documentId: document.id,
                              ),
                              const SizedBox(
                                width: 7,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
