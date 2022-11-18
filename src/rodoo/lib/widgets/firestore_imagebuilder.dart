import 'package:flutter/material.dart';
import 'package:rodoo/dao/fire_storage.dart';
import 'package:rodoo/utils/constants.dart';

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
        );
      },
    );
  }
}
