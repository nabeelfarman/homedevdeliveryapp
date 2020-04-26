import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:homemobileapp/pages/customerPages/itemsPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../main.dart';

class ShoppingCart extends StatefulWidget {
  final int customerID;
  @override
  ShoppingCart({@required this.customerID});
  @override
  _ShoppingCartState createState() => _ShoppingCartState(this.customerID);
}

class _ShoppingCartState extends State<ShoppingCart>
    with SingleTickerProviderStateMixin {
  Color blackClr = Color(0xff1D2028);

  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ffA3C12E);
  Color redClr = Color(0x0ffcf3f3d);

  Color yellowClr = Color(0x0ffF8D247);
  Color darkYellowClr = Color(0x0ffdfbd3f);
  Color lightYellowClr = Color(0x0ffffde22);
  int customerID;

  _ShoppingCartState(this.customerID);

  List cart_items = [];

  List cartItems = List();
  double totalAmount = 0.0;
  final formatter = new NumberFormat('##,###.##');

  @override
  void initState() {
    super.initState();
    this.getCartItems();
  }

  @override
  Future<String> getCartItems() async {
    try {
      var response = await http.get(
          "http://95.217.147.105:2001/api/getcartprod?CustomerID=" +
              customerID.toString(),
          headers: {
            "Content-Type": "application/json",
          });
      var responseJson = json.decode(response.body);

      for (int i = 0; i < responseJson.length; i++) {
        cart_items.add({
          'itemCode': responseJson[i]["productProfileStoreID"],
          'itemTitle': responseJson[i]["productName"],
          'price': responseJson[i]["salePrice"].toString(),
          'unit': responseJson[i]["measurementUnit"],
          'quantity': responseJson[i]["qty"].toString(),
        });
      }

      setState(() {
        cartItems = cart_items;

        this.shoppingSum();
      });
      return 'success';
    } catch (e) {
      print(e);
    }
  }

  Future<String> genOrder() async {
    try {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
          // navigateToHome(context);
        },
      );
      // pr.show();

      var now = new DateTime.now();
      // print(now);
      String currentDate = new DateFormat("yyyy-MM-dd").format(now).toString();
      print(currentDate);
      print(customerID);

      http.Response response = await http.post(
        'http://95.217.147.105:2001/api/genorder',
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
          {
            "ProfileID": customerID,
            "OrderDate": currentDate,
          },
        ),
      );

      final Map responseJson = json.decode(response.body);

      if (responseJson["msg"] == "Success") {
        // pr.hide();
        print('Success');
        navigateToOrderPlacement(context);
      } else {
        // pr.hide();

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Error!"),
          content: Text(responseJson["msg"]),
          actions: [
            okButton,
          ],
        );
        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    } catch (e) {
      // pr.hide();
      print(e);
    }
  }

  void shoppingSum() {
    totalAmount = 0.0;
    try {
      for (int i = 0; i < cartItems.length; i++) {
        var item = cartItems[i];
        totalAmount +=
            double.parse(item['price']) * double.parse(item['quantity']);

        print(totalAmount);
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
        backgroundColor: darkYellowClr,
        title: Text('Shopping Cart',
            style:
                TextStyle(color: blackClr, fontFamily: 'Anton', fontSize: 25)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              navigateToItems(context);
            },
            color: redClr,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 160.0,
            width: double.infinity,
            decoration: new BoxDecoration(
              // color: yellowClr,
              gradient: new LinearGradient(
                  colors: [darkYellowClr, lightYellowClr, yellowClr],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
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
        color: blackClr,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 80,
          color: blackClr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Total Amount',
                style: TextStyle(
                    fontFamily: 'Baloo',
                    fontWeight: FontWeight.w300,
                    fontSize: 17,
                    color: whiteClr),
              ),
              Text(
                'Rs. ' + formatter.format(totalAmount).toString(),
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: lightYellowClr),
              ),
              RaisedButton(
                elevation: 10,
                color: redClr,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  genOrder();
                },
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
          color: whiteClr,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                            color: blackClr,
                            fontFamily: 'Baloo',
                            fontSize: 18)),
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

  void navigateToItems(BuildContext context) {
    Routes.sailor.navigate('/item');
  }

  void navigateToOrderPlacement(BuildContext context) {
    Routes.sailor.navigate('/orderPlacement');
  }
}
