import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:livent/dao/fire_storage.dart';
// import 'package:livent/screens/detailed_restaurant.dart';
import 'package:livent/utils/constants.dart';

import '../screens/detailed_restaurant.dart';

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
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: rodoRose,
            ),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailedRestaurant.route,
                    arguments: data);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder<Image>(
                        future: FireStorageService.getImage(
                          context,
                          data['imageName'] + "1.jpeg",
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: snapshot.data,
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: rodoRose,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data['Name'],
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
                          data['Rating'].toString(),
                          style: ratingTextStyle,
                        )
                      ],
                    ),
                    Text(
                      // data['Address'].join(' • '),
                      data['Address'],
                      style: generalTextStyle,
                    )
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
