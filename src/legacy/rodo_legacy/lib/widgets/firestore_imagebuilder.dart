import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rodo/data_and_storage/fire_storage.dart';
import 'package:rodo/utilities/constants.dart';

class FirestoreImageBuilder extends StatelessWidget {
  final List<dynamic> imageArray;
  final int index;
  final bool interactable;
  final double radius;

  FirestoreImageBuilder(
      {required this.imageArray,
      required this.index,
      required this.interactable,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          child: FutureBuilder<Image>(
            future: FireStorageService.getImage(
              context,
              imageArray[index],
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
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
        );
      },
    );
  }
}
