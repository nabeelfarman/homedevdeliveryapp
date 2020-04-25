import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ImageCarousel extends StatelessWidget {
  Color blackClr = Color(0xff1D2028);

  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ffA3C12E);
  Color redClr = Color(0x0ffcf3f3d);

  Color yellowClr = Color(0x0ffF8D247);
  Color darkYellowClr = Color(0x0ffdfbd3f);
  Color lightYellowClr = Color(0x0ffffde22);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
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
          // dotBgColor: Colors.white.withOpacity(0.5),
          indicatorBgPadding: 4.0,
        ),
      ),
    );
  }
}
