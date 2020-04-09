import 'package:flutter/material.dart';
import 'package:homemobileapp/pages/customerHome.dart';
import 'package:homemobileapp/pages/newOrder.dart';

import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[NewOrderPage(), SideBar()],
    ));
  }
}
