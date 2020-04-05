import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItem({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color blackClr = Color(0xff2d2d2d);
    Color yellowClr = Color(0xfff7d73a);
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 16, bottom: 16),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: blackClr,
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 22, color: blackClr))
        ],
      ),
    );
  }
}
