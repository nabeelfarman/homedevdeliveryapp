import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/supplier_bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';

import '../../main.dart';

class InventoryPage extends StatefulWidget {
  final int userID;
  @override
  InventoryPage({@required this.userID});

  @override
  _InventoryPageState createState() => _InventoryPageState(this.userID);
}

class _InventoryPageState extends State<InventoryPage>
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

  String salePrice;
  String productName;
  String productID;
  int userID;
  bool isSearching = false;
  List items_data = [];

  String userName;
  int appTypeID;
  int townID;
  String email;

  ProgressDialog pr;

  List filteredItems = List();

  _InventoryPageState(this.userID);

  @override
  void initState() {
    super.initState();
    this.getItems();
    getUserData();
  }

  @override
  Future<String> getUserData() async {
    try {
      // Future.delayed(Duration(seconds: 1)).then((value) {
      //   pr.show();
      // });
      var response = await http.get(
          "http://95.217.147.105:2001/api/getuserdetail?UserID=" +
              userID.toString(),
          headers: {
            "Content-Type": "application/json",
          });
      var responseJson = json.decode(response.body);

      userID = responseJson[0]["userID"];
      userName = responseJson[0]["userName"];
      appTypeID = responseJson[0]["appTypeID"];
      email = responseJson[0]["email"];
      townID = responseJson[0]["townID"];

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
              userID.toString(),
          headers: {
            "Content-Type": "application/json",
          });

      var responseJson = json.decode(response.body);

      for (int i = 0; i < responseJson.length; i++) {
        items_data.add({
          'itemCode': responseJson[i]["productProfileStoreID"].toString(),
          'itemTitle': responseJson[i]["productName"],
          'price': responseJson[i]["salePrice"].toString(),
          // 'unit': responseJson[i]["measurementUnit"],
          'unit': 'piece',
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

  void saveItemPrice() async {
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
        'http://95.217.147.105:2001/api/altersaleprice',
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
          {
            "ProductProfileStoreID": productID,
            "SalePrice": salePrice,
            "Userid": userID,
          },
        ),
      );

      final Map responseJson = json.decode(response.body);

      if (responseJson["msg"] == "Success") {
        pr.hide();
        print('Success');
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
        valueColor: new AlwaysStoppedAnimation<Color>(lightYellowClr),
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
        leading: GestureDetector(
          onTap: () {
            navigateToSideBarLayout(context);
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: darkYellowClr,
        title: !isSearching
            ? Text('Inventory Settings',
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
                    prefixIcon: Icon(
                      Icons.search,
                      color: blackClr.withOpacity(0.4),
                    ),
                    fillColor: darkYellowClr,
                    filled: true,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blackClr)),
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
            decoration: new BoxDecoration(
              // color: yellowClr,
              gradient: new LinearGradient(
                  colors: [darkYellowClr, lightYellowClr, yellowClr],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            height: MediaQuery.of(context).size.height,
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
        onPressed: () {},
        backgroundColor: blackClr,
        child: Icon(
          Icons.notifications,
          color: lightYellowClr,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: lightYellowClr,
      bottomNavigationBar: SupplierBottomBar(),
    );
  }

  Widget buildItemCard(BuildContext context, int index) {
    final item = filteredItems[index];
    return FadeAnimation(
      1.5,
      Card(
          color: lightClr,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item['itemTitle'],
                      style: TextStyle(
                          color: blackClr,
                          fontFamily: 'Baloo',
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Rs.  ',
                        style: TextStyle(
                            color: redClr, fontFamily: 'Baloo', fontSize: 18)),
                    Flexible(
                      child: Focus(
                        child: TextFormField(
                          initialValue: item['price'],
                          key: Key('price'),
                          decoration: InputDecoration(
                            hintText: 'price',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: redClr)),
                          ),
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            // print(value);
                            salePrice = "";
                            productName = item["itemTitle"];
                            productID = item["itemCode"];
                            salePrice = value;
                          },
                        ),
                        onFocusChange: (value) {
                          if (value == true) {
                            if (salePrice == null) {
                              salePrice = "";
                            } else if (salePrice != "") {
                              saveItemPrice();
                              print(salePrice);
                              salePrice = "";
                            } else {
                              print('salePrice is empty');
                            }
                          }
                        },
                      ),
                    ),
                    // Text('  Quantity:  ',
                    //     style: TextStyle(
                    //         color: redClr, fontFamily: 'Baloo', fontSize: 18)),
                    // Flexible(
                    //     child: TextFormField(
                    //   key: Key('quantity'),
                    //   decoration: InputDecoration(
                    //     hintText: 'quantity',
                    //     focusedBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide(color: redClr)),
                    //   ),
                    //   maxLength: 5,
                    //   keyboardType: TextInputType.number,
                    //   textInputAction: TextInputAction.done,
                    // )),
                    // Text(
                    //   '  ' + item['unit'] + '   ',
                    //   style: TextStyle(
                    //       color: redClr, fontFamily: 'Baloo', fontSize: 18),
                    // ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  void navigateToSideBarLayout(BuildContext context) {
    Routes.sailor.navigate(
      '/sideBarLayout',
      params: {
        'userID': userID,
        'userName': userName,
        'appTypeID': appTypeID,
        'email': email,
        'townID': townID,
      },
    );
  }
}
