import 'package:flutter/material.dart';

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
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: Colors.white),
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
                              Icons.arrow_back,
                              color: Color(0xFFEF7532),
                            ),
                            onTap: () {
                              if (pageName == "ItemsPage") {
                                print(pageName);
                              } else {
                                print(pageName);
                              }
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
                          Icon(Icons.notifications_none,
                              color: Color(0xFF676E79))
                        ],
                      )),
                ])));
  }
}
