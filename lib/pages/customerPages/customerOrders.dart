import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:intl/intl.dart';

class CustomerOrders extends StatefulWidget {
  @override
  _CustomerOrdersState createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders>
    with SingleTickerProviderStateMixin {
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  List customer_orders = [
    {
      'orderNo': '1',
      'supplier': 'Save Mart',
      'address': 'G.T Road, G-15, Islamabad',
      'totalAmount': '1500',
      'orderStatus': 'pending'
    },
    {
      'orderNo': '2',
      'supplier': 'Madina Cash & Carry',
      'address': 'G-9 Markaz, Islamabad',
      'totalAmount': '20530',
      'orderStatus': 'Rjected'
    },
    {
      'orderNo': '3',
      'supplier': 'Punjab Cash & Carry',
      'address': 'G-9 Markaz, Islamabad',
      'totalAmount': '10365',
      'orderStatus': 'completed'
    },
    {
      'orderNo': '4',
      'supplier': 'Shaan Fruits',
      'address': 'G-14 Markaz, Islamabad',
      'totalAmount': '1500',
      'orderStatus': 'completed'
    }
  ];

  List customerOrdersList = List();
  final formatter = new NumberFormat('##,###.##');
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    this.getCustomerOrders();
  }

  Future<String> getCustomerOrders() async {
    try {
      setState(() {
        customerOrdersList = customer_orders;
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

                  // _tabController.animateTo(_tabController.index - 1);
                  print(1);
                },
                style: TextStyle(color: redClr),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: redClr,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: redClr)),
                    hintText: 'search order by supplier name',
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
              itemCount: customerOrdersList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildOrderCard(context, index),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }

  // orders widget
  Widget buildOrderCard(BuildContext context, int index) {
    final item = customerOrdersList[index];
    return FadeAnimation(
      1.5,
      Card(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item['supplier'],
                    style: TextStyle(
                        color: blackClr,
                        fontFamily: 'Baloo',
                        fontSize: 18,
                        fontWeight: FontWeight.w800)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Rs. ' + item['price'],
                    style: TextStyle(
                        color: blackClr, fontFamily: 'Baloo', fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: lightClr,
                      shape: CircleBorder(),
                      onPressed: () {
                        setState(() {
                          int qty = int.parse(item['totalAmount']);

                          if (qty > 0) {
                            item['totalAmount'] = (qty - 1).toString();
                          }
                        });
                      },
                      child: Text(
                        '-',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      item['totalAmount'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Baloo'),
                    ),
                    RaisedButton(
                      color: greenClr,
                      shape: CircleBorder(),
                      onPressed: () {
                        setState(() {
                          var qty = int.parse(item['totalAmount']);
                          if (qty < 500) {
                            item['totalAmount'] = (qty + 1).toString();
                          }
                        });
                      },
                      child: Text(
                        '+',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Rs. ' +
                      formatter
                          .format(double.parse(item['price']) *
                              double.parse(item['quantity']))
                          .toString(),
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
