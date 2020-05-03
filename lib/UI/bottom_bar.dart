import 'package:flutter/material.dart';

import '../main.dart';

class BottomBar extends StatefulWidget {
  String pageName;

  @override
  BottomBar(
    @required this.pageName,
  );

  @override
  _BottomBar createState() => _BottomBar(
        pageName,
      );
}

class _BottomBar extends State<BottomBar> {
  Color blackClr = Color(0xff1D2028);

  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ffA3C12E);
  Color redClr = Color(0x0ffcf3f3d);

  Color yellowClr = Color(0x0ffF8D247);
  Color darkYellowClr = Color(0x0ffdfbd3f);
  Color lightYellowClr = Color(0x0ffffde22);

  String pageName;

  @override
  _BottomBar(
    this.pageName,
  );

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: yellowClr,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: blackClr),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            child: Icon(
                              Icons.exit_to_app,
                              color: lightYellowClr,
                            ),
                            onTap: () {
                              navigateToLogin(context);
                            },
                          ),
                          // Icon(Icons.person_outline, color: Color(0xFF676E79))
                        ],
                      )),
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // Icon(Icons.search, color: Color(0xFF676E79)),
                          Icon(Icons.notifications_none, color: Colors.grey)
                        ],
                      )),
                ])));
  }

  void navigateToLogin(BuildContext context) {
    Routes.sailor.navigate(
      '/login',
    );
  }
}
