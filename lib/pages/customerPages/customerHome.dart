import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
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
  _CustomerHomeState createState() =>
      _CustomerHomeState(this.userID, this.townID);
}

class _CustomerHomeState extends State<CustomerHome> {
  String pageName;
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
                        pageName = "History";
                        navigateToCustomerOrder(context);
                      },
                    ),
                    GestureDetector(
                      child: HomeCard(
                        icon: Icons.slow_motion_video,
                        iconTitle: 'in-Process',
                        cardColor: greenClr,
                      ),
                      onTap: () {
                        pageName = "inProcess";
                        navigateToCustomerOrder(context);
                      },
                    ),
                    GestureDetector(
                      child: HomeCard(
                        icon: Icons.airport_shuttle,
                        iconTitle: 'Delivery',
                        cardColor: redClr,
                      ),
                      onTap: () {
                        pageName = "Delivery";
                        navigateToCustomerOrder(context);
                      },
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
      bottomNavigationBar: BottomBar(pageName),
    );
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
        'pageName': pageName,
        'userID': userID,
        'townID': townID,
      },
    );
  }
}
