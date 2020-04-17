import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/supplier_bottom_bar.dart';
import 'package:intl/intl.dart';

class SupplierOrders extends StatefulWidget {
  @override
  _SupplierOrdersState createState() => _SupplierOrdersState();
}

class _SupplierOrdersState extends State<SupplierOrders>
    with SingleTickerProviderStateMixin {
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  List supplier_orders = [
    {
      'orderNo': '1',
      'customer': 'Haroon Qadeer',
      'address': 'G.T Road, G-15, Islamabad',
      'totalAmount': '1500',
      'orderStatus': 'pending'
    },
    {
      'orderNo': '2',
      'customer': 'Imran Ejaz',
      'address': 'G-9 Markaz, Islamabad',
      'totalAmount': '20530',
      'orderStatus': 'Rjected'
    },
    {
      'orderNo': '3',
      'customer': 'Nabeel Ahmed Khan',
      'address': 'G-9 Markaz, Islamabad',
      'totalAmount': '10365',
      'orderStatus': 'completed'
    },
    {
      'orderNo': '4',
      'customer': 'Adnan Ali',
      'address': 'G-14 Markaz, Islamabad',
      'totalAmount': '1500',
      'orderStatus': 'completed'
    }
  ];

  List supplierOrdersList = List();
  final formatter = new NumberFormat('##,###.##');
  bool isSearching = false;
  Color foreColor;
  Color bgColor;

  @override
  void initState() {
    super.initState();
    this.getSupplierOrders();
  }

  @override
  void _filteredOrders(String searchText) {
    try {
      setState(() {
        supplierOrdersList = supplier_orders
            .where((item) => item['customer']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> getSupplierOrders() async {
    try {
      setState(() {
        supplierOrdersList = supplier_orders;
      });
      return 'success';
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: whiteClr,
        title: !isSearching
            ? Text('Your Orders',
                style: TextStyle(
                    color: blackClr, fontFamily: 'Josefin', fontSize: 25))
            : TextField(
                onChanged: (Text) {
                  // supplierListPage.prinText(value);
                  _filteredOrders(Text);
                  // _tabController.animateTo(_tabController.index - 1);
                },
                style: TextStyle(color: redClr),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: redClr,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: redClr)),
                    hintText: 'search order by customer name',
                    hintStyle: TextStyle(
                        color: redClr, fontFamily: 'Baloo', fontSize: 18))),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                  },
                  color: redClr)
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                  color: redClr)
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 160.0,
            width: double.infinity,
            child: new ListView.builder(
              itemCount: supplierOrdersList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildOrderCard(context, index),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: redClr,
        child: Icon(Icons.notifications),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SupplierBottomBar(),
    );
  }

  // orders widget
  Widget buildOrderCard(BuildContext context, int index) {
    final item = supplierOrdersList[index];
    return FadeAnimation(
      1.5,
      Card(
          color: whiteClr,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(item['customer'],
                        style: TextStyle(
                            color: blackClr,
                            fontFamily: 'Baloo',
                            fontSize: 18,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item['address'],
                      style: TextStyle(
                          color: blackClr, fontFamily: 'Baloo', fontSize: 18),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        'Rs. ' +
                            formatter.format(double.parse(item['totalAmount'])),
                        style: TextStyle(
                            color: blackClr,
                            fontFamily: 'Baloo',
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                    item['orderStatus'] == 'pending'
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.yellowAccent),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                item['orderStatus'],
                                style: TextStyle(
                                    color: blackClr,
                                    fontFamily: 'Baloo',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : item['orderStatus'] == 'completed'
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: greenClr),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Text(
                                    item['orderStatus'],
                                    style: TextStyle(
                                        color: blackClr,
                                        fontFamily: 'Baloo',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: redClr),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Text(
                                    item['orderStatus'],
                                    style: TextStyle(
                                        color: whiteClr,
                                        fontFamily: 'Baloo',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                    GestureDetector(
                        child: Text("Details...",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: redClr,
                                fontSize: 18,
                                fontFamily: 'Baloo')),
                        onTap: () {})
                  ],
                )
              ],
            ),
          )),
    );
  }
}
