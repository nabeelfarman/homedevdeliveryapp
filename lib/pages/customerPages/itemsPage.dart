import 'package:flutter/material.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';
import 'package:badges/badges.dart';
import '../../main.dart';

class ItemsPage extends StatefulWidget {
  final int supplierID;
  final int userID;
  final int businessID;

  @override
  ItemsPage({
    @required this.supplierID,
    @required this.userID,
    @required this.businessID,
  });

  @override
  _ItemsPageState createState() => _ItemsPageState(
        this.supplierID,
        this.userID,
        this.businessID,
      );
}

class _ItemsPageState extends State<ItemsPage>
    with SingleTickerProviderStateMixin {
  int supplierID;
  int userID;
  int businessID;
  int totalItems = 0;

  _ItemsPageState(
    this.supplierID,
    this.userID,
    this.businessID,
  );

  Color blackClr = Color(0xff1D2028);

  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ffA3C12E);
  Color redClr = Color(0x0ffcf3f3d);

  Color yellowClr = Color(0x0ffF8D247);
  Color darkYellowClr = Color(0x0ffdfbd3f);
  Color lightYellowClr = Color(0x0ffffde22);

  bool isSearching = false;

  String pageName = 'ItemsPage';
  String productID;
  String qty;
  String salePrice;

  List items_data = [];

  List filteredItems = List();

  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    this.getItems();
    this.getCartItems();
  }

  @override
  Future<String> getCartItems() async {
    try {
      // Future.delayed(Duration(seconds: 1)).then((value) {
      //   pr.show();
      // });
      var response = await http.get(
          "http://95.217.147.105:2001/api/getcartprod?CustomerID=" +
              userID.toString(),
          headers: {
            "Content-Type": "application/json",
          });
      var responseJson = json.decode(response.body);

      setState(() {
        totalItems = responseJson.length;
      });

      // Future.delayed(Duration(seconds: 2)).then((value) {
      //   pr.hide();
      // });

      return 'success';
    } catch (e) {
      // Future.delayed(Duration(seconds: 2)).then((value) {
      //   pr.hide();
      // });

      print(e);
    }
  }

  @override
  void _filteredItems(String searchText) {
    try {
      setState(() {
        filteredItems = items_data
            .where((item) => item['itemTitle']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> getItems() async {
    try {
      Future.delayed(Duration(seconds: 1)).then((value) {
        pr.show();
      });

      var response = await http.get(
          "http://95.217.147.105:2001/api/getmerchantproducts?MerchantID=" +
              supplierID.toString() +
              "&BusinessID=" +
              businessID.toString(),
          headers: {
            "Content-Type": "application/json",
          });

      var responseJson = json.decode(response.body);

      for (int i = 0; i < responseJson.length; i++) {
        items_data.add({
          'itemCode': responseJson[i]["productProfileStoreID"],
          'itemTitle': responseJson[i]["productName"],
          'price': responseJson[i]["salePrice"].toString(),
          'unit': responseJson[i]["measurementUnit"],
          'quantity': responseJson[i]["qty"].toString(),
        });
      }

      setState(() {
        filteredItems = items_data;
      });

      Future.delayed(Duration(seconds: 2)).then((value) {
        pr.hide();
      });

      return 'success';
    } catch (e) {
      print(e);

      Future.delayed(Duration(seconds: 2)).then((value) {
        pr.hide();
      });
    }
  }

  Future<String> addToCart() async {
    try {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
          // navigateToHome(context);
        },
      );
      pr.show();

      http.Response response = await http.post(
        'http://95.217.147.105:2001/api/addtocart',
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
          {
            "productProfileStoreID": productID,
            "CustomerID": userID,
            "MerchantID": supplierID,
            "Qty": 1,
            "SalePrice": salePrice,
            "Remarks": "-"
          },
        ),
      );

      final Map responseJson = json.decode(response.body);

      if (responseJson["msg"] == "Success") {
        getCartItems();
        pr.hide();
        print('Success');
        // navigateToShoppingCart(context);
      } else {
        pr.hide();

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
      pr.hide();
      print(e);
    }
  }

  Future<String> removeToCart() async {
    try {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
          // navigateToHome(context);
        },
      );
      pr.show();

      http.Response response = await http.post(
        'http://95.217.147.105:2001/api/delfromcart',
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
          {
            "productProfileStoreID": productID,
            "CustomerID": userID,
            // "MerchantID": supplierID,
          },
        ),
      );

      final Map responseJson = json.decode(response.body);

      if (responseJson["msg"] == "Success") {
        getCartItems();
        pr.hide();
        print('Success');
        // navigateToShoppingCart(context);
      } else {
        pr.hide();

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
      pr.hide();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
      message: 'Please Wait...',
      borderRadius: 10.0,
      backgroundColor: blackClr,
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(greenClr),
      ),
      elevation: 20.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: darkYellowClr,
        title: !isSearching
            ? Text('Select Items',
                style: TextStyle(
                    color: blackClr, fontFamily: 'Anton', fontSize: 25))
            : TextField(
                onChanged: (Text) {
                  // supplierListPage.prinText(value);
                  _filteredItems(Text);
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
                    hintText: 'search item',
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
            height: MediaQuery.of(context).size.height - 50.0,
            width: double.infinity,
            decoration: new BoxDecoration(
              // color: yellowClr,
              gradient: new LinearGradient(
                  colors: [darkYellowClr, lightYellowClr, yellowClr],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: new ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildItemCard(context, index),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToShoppingCart(context);
        },
        backgroundColor: blackClr,
        child: totalItems != 0
            ? Badge(
                child: Icon(
                  Icons.shopping_cart,
                  color: lightYellowClr,
                ),
                badgeContent: Text(
                  totalItems.toString(),
                ),
                badgeColor: Colors.white,
                animationType: BadgeAnimationType.scale,
              )
            : Icon(
                Icons.shopping_cart,
                color: lightYellowClr,
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: lightYellowClr,
      bottomNavigationBar: BottomBar(
        pageName,
      ),
    );
  }

  Widget buildItemCard(BuildContext context, int index) {
    final item = filteredItems[index];
    return FadeAnimation(
      1.0,
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

                                productID = item['itemCode'].toString();

                                removeToCart();
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

                                productID = item['itemCode'].toString();
                                salePrice = item['price'].toString();

                                addToCart();
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
                  ],
                )
              ],
            ),
          )),
    );
  }

  void navigateToShoppingCart(BuildContext context) {
    Routes.sailor.navigate(
      '/shoppingCart',
      params: {
        'customerID': userID,
      },
    );
  }

  void navigateToOrderPage(BuildContext context) {
    Routes.sailor.navigate('/newOrder');
  }
}
