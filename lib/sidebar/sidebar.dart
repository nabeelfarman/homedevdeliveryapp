import 'dart:async';
import 'package:homemobileapp/sidebar/menu_item.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  //declaration
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSideBarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;

  Color blackClr = Color(0xff2d2d2d);

  Color yellowClr = Color(0xfff7d73a);

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
            right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: yellowClr,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                        ),
                        ListTile(
                          title: Text(
                            'Haroon Qadeer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text('haroon.qadeer@hotmail.com',
                              style: TextStyle(color: blackClr, fontSize: 16)),
                          leading: CircleAvatar(
                            child: Icon(Icons.shopping_basket,
                                color: Colors.white),
                            radius: 40,
                            backgroundColor: blackClr,
                          ),
                        ),
                        Divider(
                          height: 64,
                          thickness: 0.5,
                          color: blackClr.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(icon: Icons.home, title: 'Home Page'),
                        MenuItem(
                            icon: Icons.shopping_basket, title: 'My Orders'),
                        Divider(
                          height: 64,
                          thickness: 0.5,
                          color: blackClr.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(icon: Icons.settings, title: 'Settings'),
                        MenuItem(icon: Icons.exit_to_app, title: 'Log Out'),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment(0, -0.9),
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
                            color: yellowClr,
                            child: AnimatedIcon(
                              color: blackClr,
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
