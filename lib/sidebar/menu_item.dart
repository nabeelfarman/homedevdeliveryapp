import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItem({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color blackClr = Color(0xff2d2d2d);
    Color whiteClr = Color(0xffffffff);
    Color redClr = Color(0x0fff0513c);
    Color greenClr = Color(0x0ff8ee269);

    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 16, bottom: 16),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: whiteClr,
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: whiteClr,
                  fontFamily: 'Baloo'))
        ],
      ),
    );
  }
}
