import 'dart:async';
import 'package:homemobileapp/pages/newOrder.dart';
import 'package:homemobileapp/sidebar/menu_item.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:homemobileapp/main.dart';
import 'package:homemobileapp/pages/newOrder.dart';
import 'package:homemobileapp/navigationBloc/navigationBlock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemobileapp/navigationBloc/navigationBlock.dart';
import 'package:sailor/sailor.dart';

class SideBar extends StatefulWidget {
  int userID;
  String userName;
  int appTypeID;
  String email;
  int townID;

  @override
  SideBar(
    @required this.userID,
    @required this.userName,
    @required this.appTypeID,
    @required this.email,
    @required this.townID,
  );

  //declaration
  @override
  _SideBarState createState() => _SideBarState(
        userID,
        userName,
        appTypeID,
        email,
        townID,
      );
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  int userID;
  String userName;
  int appTypeID;
  String email;
  int townID;

  @override
  _SideBarState(
    this.userID,
    this.userName,
    this.appTypeID,
    this.email,
    this.townID,
  );

  AnimationController _animationController;
  StreamController<bool> isSideBarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;

  Color blackClr = Color(0xff1D2028);

  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ffA3C12E);
  Color redClr = Color(0x0ffcf3f3d);

  Color yellowClr = Color(0x0ffF8D247);
  Color darkYellowClr = Color(0x0ffdfbd3f);
  Color lightYellowClr = Color(0x0ffffde22);

  // final bool isSidebarOpened = true;

  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSideBarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSideBarOpenedStreamController.stream;
    isSideBarOpenedSink = isSideBarOpenedStreamController.sink;

    print(userID);
    print(userName);
    print(appTypeID);
    print(email);
    print(townID);
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSideBarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
        initialData: false,
        stream: isSideBarOpenedStream,
        builder: (context, isSideBarOpenedAsync) {
          return AnimatedPositioned(
            duration: _animationDuration,
            top: 0,
            bottom: 0,
            left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
            right: isSideBarOpenedAsync.data ? 0 : screenWidth - 36,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Material(
                    elevation: 20,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [blackClr, blackClr])),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                          ),
                          ListTile(
                            title: Text(
                              userName
                                      .trimLeft()
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  userName.trimRight().substring(1),
                              style: TextStyle(
                                  color: redClr,
                                  // fontFamily: 'Lato',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800),
                            ),
                            subtitle: Text(email,
                                style:
                                    TextStyle(color: lightClr, fontSize: 16)),
                            leading: CircleAvatar(
                              child: Icon(Icons.shopping_basket,
                                  color: Colors.white),
                              radius: 40,
                              backgroundColor: redClr,
                            ),
                          ),
                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: whiteClr.withOpacity(0.5),
                            indent: 32,
                            endIndent: 32,
                          ),
                          GestureDetector(
                            child: MenuItem(
                              icon: Icons.home,
                              title: 'Home Page',
                            ),
                            onTap: () {
                              onIconPressed();
                              print(userID);
                              BlocProvider.of<NavigationBloc>(context)
                                  .add(customerHome(
                                userID: userID,
                                townID: townID,
                              ));
                            },
                          ),
                          GestureDetector(
                            child: MenuItem(
                              icon: Icons.shopping_basket,
                              title: 'My Orders',
                            ),
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(context)
                                  .add(newOrder(
                                userID: userID,
                                townID: townID,
                              ));
                            },
                          ),
                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: whiteClr.withOpacity(0.7),
                            indent: 32,
                            endIndent: 32,
                          ),
                          MenuItem(icon: Icons.settings, title: 'Settings'),
                          MenuItem(icon: Icons.exit_to_app, title: 'Log Out'),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment(0, -0.95),
                    child: GestureDetector(
                      onTap: () {
                        onIconPressed();
                      },
                      child: ClipPath(
                        clipper: CustomMenuClipper(),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 35,
                            height: 110,
                            color: blackClr,
                            child: AnimatedIcon(
                              color: yellowClr,
                              progress: _animationController.view,
                              icon: AnimatedIcons.menu_close,
                              size: 25,
                            )),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Color(0xff2d2d2d);

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
