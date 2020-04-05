import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';

class SupplierSelection extends StatefulWidget {
  @override
  _SupplierSelectionState createState() => _SupplierSelectionState();
}

class _SupplierSelectionState extends State<SupplierSelection> {
  //declaration
  Color blackClr = Color(0xff2d2d2d);
  Color yellowClr = Color(0xfff7d73a);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: blackClr,
        title: Text('Home Delivery'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
              color: yellowClr)
        ],
      ),
    );
  }
}
