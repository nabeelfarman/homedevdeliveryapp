import 'package:flutter/material.dart';

class CustomLoginInput extends StatelessWidget {
  Icon fieldIcon;
  String hintText;

  CustomLoginInput(this.fieldIcon, this.hintText);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 300,
      height: 60,
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Color(0xff8cc540),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: fieldIcon,
            ), // padding
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0))),
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        fillColor: Colors.white,
                        filled: true), // decoration
                    style: TextStyle(
                        fontSize: 20.0, color: Colors.black), // Text Sytle
                  ), // user name field
                )), // username input container
          ],
        ), // row username
      ), // material
    ); // widget container
  }
}
