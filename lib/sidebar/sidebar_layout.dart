import 'package:flutter/material.dart';
import 'package:homemobileapp/navigationBloc/navigationBlock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(),
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
