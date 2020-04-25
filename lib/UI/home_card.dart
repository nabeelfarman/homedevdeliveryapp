import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String iconTitle;
  final Color cardColor;

  const HomeCard({Key key, this.icon, this.iconTitle, this.cardColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //declaration
    Color blackClr = Color(0xff2d2d2d);
    // Color yellowClr = Color(0xfff7d73a);
    Color whiteClr = Color(0x0ffffffff);
    Color lightClr = Color(0x0fffdebe7);
    Color purpleClr = Color(0x0ffd183fd);
    Color greenClr = Color(0x0ff8ee269);
    Color redClr = Color(0x0fff0513c);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: whiteClr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: redClr,
                size: 60.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(iconTitle,
                    style: TextStyle(
                        color: blackClr,
                        fontSize: 20.0,
                        fontFamily: 'Baloo',
                        fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
