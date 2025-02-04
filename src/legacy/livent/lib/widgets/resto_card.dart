import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:livent/dao/fire_storage.dart';
import 'package:livent/screens/detailed_restaurant.dart';
import 'package:livent/utils/constants.dart';

class RestoWidget extends StatelessWidget {
  RestoWidget({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('restaurants').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong trying to build firestore stream: ${snapshot.error}',
          );
        } else {
          if (kDebugMode) {
            print(snapshot);
          }
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }

        return ListView(
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
                      height: 8,
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
                                )
                              ],
                            ),
                            Text(
                              // data['Address'].join(' • '),
                              "${data['street']} ${data['street_number']}",
                              style: generalTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                data["is_favorite"]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 33,
                              ),
                              onPressed: () => {},
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
        );
      },
    );
  }
}
