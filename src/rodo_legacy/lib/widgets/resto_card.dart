import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rodo/data_and_storage/fire_storage.dart';
import 'package:rodo/screens/detailed_restaurant.dart';
import 'package:rodo/utilities/constants.dart';

class RestoWidget extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('restaurants').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong trying to build firestore stream');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
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
                Navigator.pushNamed(
                  context,
                  DetailedRestaurant.route,
                  arguments: data
                );
              },
              child: Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder<Image>(
                        future: FireStorageService.getImage(
                          context,
                          data['imageName'][0],
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: snapshot.data,
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: rodoRose,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data['name'],
                          style: restoNameTextStyle,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
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
                      data['food_type'].join(' • '),
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
