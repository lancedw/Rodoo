import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FullscreenCarousel extends StatelessWidget {
  static const String route = '/fullscreen';
  final List<Widget> imageArray;

  const FullscreenCarousel({super.key, required this.imageArray});

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
                return SizedBox(
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
