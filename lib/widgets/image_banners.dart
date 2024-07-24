import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageBanners extends StatelessWidget {
  const ImageBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage('assets/banner${index + 1}.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 2 / 3,
        initialPage: 0,
      ),
    );
  }
}
