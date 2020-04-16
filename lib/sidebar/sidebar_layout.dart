import 'package:flutter/material.dart';
import 'package:homemobileapp/pages/customerPages/customerHome.dart';
import 'package:homemobileapp/pages/customerPages/customerOrderDetails.dart';
import 'package:homemobileapp/pages/customerPages/customerOrders.dart';
import 'package:homemobileapp/pages/customerPages/itemsPage.dart';
import 'package:homemobileapp/pages/customerPages/orderPlacement.dart';
import 'package:homemobileapp/pages/customerPages/shoppingCart.dart';
import 'package:homemobileapp/pages/newOrder.dart';
import 'package:homemobileapp/pages/supplierPages/inventory.dart';
import 'package:homemobileapp/pages/supplierPages/supplierHome.dart';
import 'package:homemobileapp/pages/supplierPages/supplierOrderDetails.dart';
import 'package:homemobileapp/pages/supplierPages/supplierOrders.dart';

import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[InventoryPage(), SideBar()],
    ));
  }
}
