import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/home_card.dart';
import 'package:homemobileapp/UI/image_carousel.dart';
import 'package:homemobileapp/navigationBloc/navigationBlock.dart';

import '../../main.dart';

class CustomerHome extends StatefulWidget with NavigationStates {
  final int userID;
  final int townID;

  @override
  CustomerHome({
    @required this.userID,
    @required this.townID,
  });

  @override
  _CustomerHomeState createState() => _CustomerHomeState(
        this.userID,
        this.townID,
      );
}

class _CustomerHomeState extends State<CustomerHome> {
  int userID;
  int townID;

  @override
  _CustomerHomeState(this.userID, this.townID);

  @override
  void initState() {
    super.initState();
    print(userID);
  }

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
                    GestureDetector(
                      child: HomeCard(
                        icon: Icons.assignment,
                        iconTitle: 'New Order',
                        cardColor: redClr,
                      ),
                      onTap: () {
                        navigateToNewOrder(context);
                      },
                    ),
                    GestureDetector(
                      child: HomeCard(
                        icon: Icons.history,
                        iconTitle: 'History',
                        cardColor: greenClr,
                      ),
                      onTap: () {
                        navigateToCustomerOrder(context);
                      },
                    ),
                    HomeCard(
                      icon: Icons.slow_motion_video,
                      iconTitle: 'in-Process',
                      cardColor: greenClr,
                    ),
                    HomeCard(
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

  void navigateToNewOrder(BuildContext context) {
    Routes.sailor.navigate(
      '/newOrder',
      params: {
        'userID': userID,
        'townID': townID,
      },
    );
  }

  void navigateToCustomerOrder(BuildContext context) {
    Routes.sailor.navigate(
      '/customerOrder',
      params: {
        'userID': userID,
        'townID': townID,
      },
    );
  }
}
