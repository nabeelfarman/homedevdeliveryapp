import 'package:flutter/material.dart';
import 'package:homemobileapp/pages/customerPages/customerHome.dart';
import 'package:homemobileapp/pages/customerPages/customerOrders.dart';
import 'package:homemobileapp/pages/customerPages/itemsPage.dart';
import 'package:homemobileapp/pages/customerPages/orderPlacement.dart';
import 'package:homemobileapp/pages/customerPages/shoppingCart.dart';
import 'package:homemobileapp/pages/newOrder.dart';

import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[CustomerOrders(), SideBar()],
    ));
  }
}
