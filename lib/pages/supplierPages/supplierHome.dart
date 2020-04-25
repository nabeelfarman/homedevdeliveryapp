import 'package:flutter/material.dart';
import 'package:homemobileapp/UI/image_carousel.dart';
import 'package:homemobileapp/UI/supplier_bottom_bar.dart';
import 'package:homemobileapp/UI/supplier_home_card.dart';
import 'package:homemobileapp/navigationBloc/navigationBlock.dart';

import '../../main.dart';

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
  Color blackClr = Color(0xff1D2028);

  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ffA3C12E);
  Color redClr = Color(0x0ffcf3f3d);

  Color yellowClr = Color(0x0ffF8D247);
  Color darkYellowClr = Color(0x0ffdfbd3f);
  Color lightYellowClr = Color(0x0ffffde22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: darkYellowClr,
        title: Text('Home Delivery',
            style:
                TextStyle(color: blackClr, fontFamily: 'Anton', fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: new BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100),
          decoration: new BoxDecoration(
            // color: yellowClr,
            gradient: new LinearGradient(
                colors: [darkYellowClr, lightYellowClr, yellowClr],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * (2 / 7),
                child: ImageCarousel(),
              ),
              Container(
                height: MediaQuery.of(context).size.height * (3.7 / 7),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    GestureDetector(
                      child: SupplierHomeCard(
                        icon: Icons.storage,
                        iconTitle: 'Inventory',
                        cardColor: redClr,
                      ),
                      onTap: () {
                        navigateToInventory(context);
                      },
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: blackClr,
        child: Icon(
          Icons.notifications,
          color: lightYellowClr,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: yellowClr,
      bottomNavigationBar: SupplierBottomBar(),
    );
  }

  void navigateToSupplierOrder(BuildContext context) {
    Routes.sailor.navigate(
      '/supplierOrder',
      params: {
        'userID': userID,
        'townID': townID,
      },
    );
  }

  void navigateToInventory(BuildContext context) {
    Routes.sailor.navigate(
      '/inventory',
    );
  }
}
