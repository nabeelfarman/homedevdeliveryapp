import 'package:flutter/material.dart';
import 'package:homemobileapp/UI/image_carousel.dart';
import 'package:homemobileapp/UI/supplier_home_card.dart';
import 'package:homemobileapp/navigationBloc/navigationBlock.dart';

class SupplierHome extends StatefulWidget with NavigationStates {
  final int userID;
  final int townID;

  @override
  SupplierHome({@required this.userID, @required this.townID});

  @override
  _SupplierHomeState createState() =>
      _SupplierHomeState(this.userID, this.townID);
}

class _SupplierHomeState extends State<SupplierHome> {
  int userID;
  int townID;

  @override
  _SupplierHomeState(this.userID, this.townID);

  //declaration
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: whiteClr,
          title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('Home Delivery',
                style: TextStyle(color: blackClr, fontFamily: 'Josefin')),
          ),
          actions: <Widget>[
            new IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
                color: redClr)
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: lightClr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 190,
                child: ImageCarousel(),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 270,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    SupplierHomeCard(
                      icon: Icons.storage,
                      iconTitle: 'Inventory',
                      cardColor: redClr,
                    ),
                    SupplierHomeCard(
                      icon: Icons.assignment,
                      iconTitle: 'Orders',
                      cardColor: greenClr,
                    ),
                    SupplierHomeCard(
                      icon: Icons.slow_motion_video,
                      iconTitle: 'in-Process',
                      cardColor: greenClr,
                    ),
                    SupplierHomeCard(
                      icon: Icons.airport_shuttle,
                      iconTitle: 'Delivery',
                      cardColor: redClr,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
