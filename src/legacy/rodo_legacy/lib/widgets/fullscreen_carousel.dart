import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rodo/widgets/firestore_imagebuilder.dart';

class FullscreenCarousel extends StatelessWidget {
  static const String route = '/fullscreen';
  final List<Widget> imageArray;

  const FullscreenCarousel({required this.imageArray});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'carouselSlider',
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                height: MediaQuery.of(context).size.height,
              ),
              items: imageArray.map((image) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: image,
                );
              }).toList(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
