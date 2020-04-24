import 'package:flutter/material.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';
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

  _ItemsPageState(
    this.supplierID,
    this.userID,
    this.businessID,
  );

  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

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

    print("value: $businessID");
    print("supplier: $supplierID");
    this.getItems();
    // print(items_data.toList());
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
      // showProgressDialog(context, "Please Wait");
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
      return 'success';
    } catch (e) {
      print(e);
      pr.hide();
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

  static showProgressDialog(BuildContext context, String title) {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Flexible(
                      flex: 8,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            );
          });
    } catch (e) {
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
        backgroundColor: whiteClr,
        title: !isSearching
            ? Text('Select Items',
                style: TextStyle(
                    color: blackClr, fontFamily: 'Josefin', fontSize: 25))
            : TextField(
                onChanged: (Text) {
                  // supplierListPage.prinText(value);
                  _filteredItems(Text);
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
                    hintText: 'search item',
                    hintStyle: TextStyle(
                        color: redClr, fontFamily: 'Baloo', fontSize: 18))),
      ),
      body: ListView(
        children: <Widget>[
          FadeAnimation(
            1.0,
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
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
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 180.0,
            width: double.infinity,
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
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(
        pageName,
      ),
    );
  }

  Widget buildItemCard(BuildContext context, int index) {
    final item = filteredItems[index];
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
