import 'package:flutter/material.dart';

class SupplierHomeCard extends StatelessWidget {
  final IconData icon;
  final String iconTitle;
  final Color cardColor;

  const SupplierHomeCard({Key key, this.icon, this.iconTitle, this.cardColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //declaration
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
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: whiteClr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
