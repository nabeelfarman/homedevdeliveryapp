import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:intl/intl.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart>
    with SingleTickerProviderStateMixin {
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  List cart_items = [
    {
      'itemCode': '21',
      'itemTitle': 'Pespsi 1.5 Ltr',
      'price': '150',
      'unit': 'piece',
      'quantity': '10'
    },
    {
      'itemCode': '22',
      'itemTitle': 'Dalada Banaspati',
      'price': '180',
      'unit': 'liter',
      'quantity': '5'
    },
    {
      'itemCode': '23',
      'itemTitle': 'Sensodyn Toothpaste',
      'price': '230',
      'unit': 'piece',
      'quantity': '1'
    },
    {
      'itemCode': '24',
      'itemTitle': 'Surf Excel 1kg',
      'price': '530',
      'unit': '1 kg',
      'quantity': '3'
    }
  ];

  List cartItems = List();
  double totalAmount = 0;
  final formatter = new NumberFormat('##,###.##');

  @override
  void initState() {
    super.initState();
    this.getCartItems();
    this.shoppingSum();
  }

  @override
  Future<String> getCartItems() async {
    try {
      setState(() {
        cartItems = cart_items;
      });
      return 'success';
    } catch (e) {
      print(e);
    }
  }

  void shoppingSum() {
    totalAmount = 0;
    try {
      for (int i = 0; i < cartItems.length; i++) {
        var item = cartItems[i];
        totalAmount += int.parse(item['price']) * int.parse(item['quantity']);
      }
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
        title: Text('Shopping Cart',
            style: TextStyle(
                color: blackClr, fontFamily: 'Josefin', fontSize: 25)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back), onPressed: () {}, color: redClr)
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 160.0,
            width: double.infinity,
            child: new ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildItemCard(context, index),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: whiteClr,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 80,
          color: whiteClr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Total Amount',
                style: TextStyle(
                    fontFamily: 'Baloo',
                    fontWeight: FontWeight.w300,
                    fontSize: 17),
              ),
              Text(
                'Rs. ' + formatter.format(totalAmount).toString(),
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: redClr),
              ),
              RaisedButton(
                color: redClr,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                child: Text(
                  'Check Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Baloo', color: whiteClr, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemCard(BuildContext context, int index) {
    final item = cartItems[index];
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
                Text(item['itemTitle'],
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
                          int qty = int.parse(item['quantity']);

                          if (qty > 0) {
                            item['quantity'] = (qty - 1).toString();
                            shoppingSum();
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
                      item['quantity'],
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
                          var qty = int.parse(item['quantity']);
                          if (qty < 500) {
                            item['quantity'] = (qty + 1).toString();
                            shoppingSum();
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
