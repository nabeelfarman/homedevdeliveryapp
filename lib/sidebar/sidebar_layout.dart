import 'package:flutter/material.dart';
import 'package:homemobileapp/navigationBloc/navigationBlock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemobileapp/pages/customerPages/customerHome.dart';

import 'sidebar.dart';

class SideBarLayout extends StatefulWidget {
  final int userID;
  final String userName;
  final int appTypeID;
  final String email;
  final int townID;

  @override
  SideBarLayout({
    @required this.userID,
    @required this.userName,
    @required this.appTypeID,
    @required this.email,
    @required this.townID,
  });

  _SideBarLayout createState() => _SideBarLayout(
        this.userID,
        this.userName,
        this.appTypeID,
        this.email,
        this.townID,
      );
}

class _SideBarLayout extends State<SideBarLayout> {
  final int userID;
  final String userName;
  final int appTypeID;
  final String email;
  final int townID;

  @override
  _SideBarLayout(
    this.userID,
    this.userName,
    this.appTypeID,
    this.email,
    this.townID,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(
        userID,
        townID,
        appTypeID,
      ),
      child: Stack(
        children: <Widget>[
          BlocBuilder<NavigationBloc, NavigationStates>(
            builder: (context, navigationState) {
              return navigationState as Widget;
            },
          ),
          SideBar(
            userID,
            userName,
            appTypeID,
            email,
            townID,
          ),
        ],
      ),
    ));
  }
}
