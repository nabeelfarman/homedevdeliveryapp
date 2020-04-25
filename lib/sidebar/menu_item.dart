import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItem({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color blackClr = Color(0xff1D2028);

    Color whiteClr = Color(0x0ffffffff);
    Color lightClr = Color(0x0ffEEF2F5);
    Color greyClr = Color(0x0ffB5BED0);
    Color greenClr = Color(0x0ffA3C12E);
    Color redClr = Color(0x0ffcf3f3d);

    Color yellowClr = Color(0x0ffF8D247);
    Color darkYellowClr = Color(0x0ffdfbd3f);
    Color lightYellowClr = Color(0x0ffffde22);

    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 16, bottom: 16),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: lightClr,
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: yellowClr,
                  fontFamily: 'Baloo'))
        ],
      ),
    );
  }
}
