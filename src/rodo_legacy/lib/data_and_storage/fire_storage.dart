import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStorageService extends ChangeNotifier {
  static Future<String> loadImage(BuildContext context, String image) async {
    return FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

  static Future<Image> getImage(BuildContext context, String imageName) async {
    late Image image;
    await loadImage(context, imageName).then((value) {
      image = Image.network(
        value,
        fit: BoxFit.cover,
      );
    });
    return image;
  }
}
