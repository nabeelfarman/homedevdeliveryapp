import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ImageCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/carousel/1.jpg'),
          AssetImage('assets/images/carousel/0.jpg'),
          AssetImage('assets/images/carousel/2.jpg'),
          AssetImage('assets/images/carousel/5.jpg'),
          AssetImage('assets/images/carousel/3.jpg'),
          AssetImage('assets/images/carousel/4.jpg')
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
      ),
    );
  }
}
