import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SupplierOrderDetails extends StatefulWidget {
  final String pageName;
  final String orderNo;
  final String customer;
  final String address;
  final String status;

  @override
  SupplierOrderDetails({
    @required this.pageName,
    @required this.orderNo,
    @required this.customer,
    @required this.address,
    @required this.status,
  });

  @override
  _SupplierOrderDetailsState createState() => _SupplierOrderDetailsState(
        this.pageName,
        this.orderNo,
        this.customer,
        this.address,
        this.status,
      );
}

class _SupplierOrderDetailsState extends State<SupplierOrderDetails>
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

  String pageName;
  String orderNo;
  String customer;
  String address;
  String status;
  String statusText;
  final formatter = new NumberFormat('##,###.##');
  double totalAmount = 0;
  bool _isBtnDisabled;

  _SupplierOrderDetailsState(
    this.pageName,
    this.orderNo,
    this.customer,
    this.address,
    this.status,
  );

  List orderStatus = [];

  List cartItems = [];

  @override
  void initState() {
    super.initState();

    print(pageName);

    if (status == "confirm" && pageName == "Orders") {
      statusText = "Order already confirmed";
    } else if (status == "rejected") {
      statusText = "Order already rejected";
    } else if (status == "cancel") {
      statusText = "Order already canceled";
    } else if (status == "completed") {
      statusText = "Order already completed";
    }

    if (status == "pending") {
      _isBtnDisabled = true;
    } else {
      _isBtnDisabled = false;
    }

    getOrderDetail();
  }

  Future<String> getOrderDetail() async {
    try {
      var response = await http.get(
          "http://95.217.147.105:2001/api/getorderdetail?OrderID=" +
              orderNo.toString(),
          headers: {
            "Content-Type": "application/json",
          });
      var responseJson = json.decode(response.body);

      List tempList = [];
      for (int i = 0; i < responseJson["aRows"].length; i++) {
        String oDate = responseJson["aRows"][i]["gendate"];

        String date = oDate.substring(0, 9);
        String time;
        if (responseJson["aRows"][i]["gendate"].length == 21) {
          time = oDate.substring(10, 21);
        } else {
          time = oDate.substring(10, 20);
        }

        print(time);
        orderStatus.add({
          'orderState': responseJson["aRows"][i]["orderStatus"].toString(),
          'deliveryTime': "-",
          'stateTime': time,
        });
      }
      for (int i = 0; i < responseJson["pRows"].length; i++) {
        tempList.add({
          'itemCode':
              responseJson["pRows"][i]["productProfileStoreID"].toString(),
          'itemTitle': responseJson["pRows"][i]["productName"],
          'price': responseJson["pRows"][i]["salePrice"].toString(),
          'unit': responseJson["pRows"][i]["measurementUnit"],
          'quantity': responseJson["pRows"][i]["qty"].toString(),
        });
      }

      setState(() {
        cartItems = tempList;

        this.shoppingSum();
      });
      return 'success';
    } catch (e) {
      print(e);
    }
  }

  Future<String> acceptCustomerOrder() async {
    try {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
          // navigateToHome(context);
        },
      );

      http.Response response = await http.post(
        'http://95.217.147.105:2001/api/confirmorder',
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
          {
            "OrderId": orderNo,
          },
        ),
      );

      final Map responseJson = json.decode(response.body);

      if (responseJson["msg"] == "Success") {
        // pr.hide();
        print('Success');

        _isBtnDisabled = false;
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
      print(e);
    }
  }

  Future<String> deliverCustomerOrder() async {
    try {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
          // navigateToHome(context);
        },
      );

      http.Response response = await http.post(
        'http://95.217.147.105:2001/api/deliverbysup',
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
          {
            "OrderId": orderNo,
          },
        ),
      );

      final Map responseJson = json.decode(response.body);

      if (responseJson["msg"] == "Success") {
        // pr.hide();
        print('Success');

        _isBtnDisabled = false;
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
      print(e);
    }
  }

  Future<String> rejectCustomerOrder() async {
    try {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
          // navigateToHome(context);
        },
      );

      http.Response response = await http.post(
        'http://95.217.147.105:2001/api/rejectbysuporder',
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
          {
            "OrderId": orderNo,
          },
        ),
      );

      final Map responseJson = json.decode(response.body);

      if (responseJson["msg"] == "Success") {
        // pr.hide();
        print('Success');

        _isBtnDisabled = false;
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
      print(e);
    }
  }

  void orderResponse(String title) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        // navigateToHome(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error!"),
      content: Text(title),
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
          backgroundColor: darkYellowClr,
          title: Text('Order No. ' + orderNo + ' Detail',
              style: TextStyle(
                  color: blackClr, fontFamily: 'Anton', fontSize: 25))),
      body: SingleChildScrollView(
          child: Container(
        decoration: new BoxDecoration(
          // color: yellowClr,
          gradient: new LinearGradient(
              colors: [darkYellowClr, lightYellowClr, yellowClr],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        width: MediaQuery.of(context).size.width,
        constraints:
            new BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                customer,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: redClr,
                    fontFamily: 'Baloo',
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                address,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: orderStatus.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildOrderStatusCard(context, index),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              width: double.infinity,
              child: FadeAnimation(
                1.0,
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            key: Key('EstimatedTime'),
                            decoration: InputDecoration(
                                hintText: '',
                                prefixIcon: Icon(
                                  Icons.watch_later,
                                  color: redClr,
                                )),
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Text(
                          'time in minutes for delivery',
                          style: TextStyle(
                              color: Colors.black45,
                              fontFamily: 'Baloo',
                              fontSize: 17),
                        )
                      ],
                    ),
                    TextFormField(
                      key: Key('Remarks'),
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintText: 'comments and remarks', hintMaxLines: 4),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => {
                              if (_isBtnDisabled == true)
                                {
                                  rejectCustomerOrder(),
                                }
                              else
                                {
                                  orderResponse(statusText),
                                }
                            },
                            elevation: 5,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 5, 20, 5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10)),
                            color: redClr,
                            child: Text(
                              'Reject',
                              style: TextStyle(
                                  color: whiteClr,
                                  fontFamily: 'Baloo',
                                  fontSize: 20),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () => {
                              if (pageName == "Orders")
                                {
                                  if (_isBtnDisabled == true)
                                    {
                                      acceptCustomerOrder(),
                                    }
                                  else
                                    {
                                      orderResponse(statusText),
                                    }
                                }
                              else if (pageName == "inProcess")
                                {
                                  if (status == "confirm")
                                    {
                                      _isBtnDisabled = true,
                                    },
                                  if (_isBtnDisabled == true)
                                    {
                                      deliverCustomerOrder(),
                                    }
                                  else
                                    {
                                      orderResponse(statusText),
                                    }
                                },
                            },
                            elevation: 5,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 5, 20, 5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10)),
                            color: blackClr,
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                  color: whiteClr,
                                  fontFamily: 'Baloo',
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 30,
              thickness: 0.5,
              color: blackClr.withOpacity(0.5),
            ),
            Text('Shopping Cart',
                style: TextStyle(
                    color: redClr,
                    fontFamily: 'Baloo',
                    fontSize: 25,
                    fontWeight: FontWeight.w600)),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartItems.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildItemCard(context, index),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total Amount',
                    style: TextStyle(
                        fontFamily: 'Baloo',
                        fontWeight: FontWeight.w700,
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
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget buildOrderStatusCard(BuildContext context, int index) {
    final item = orderStatus[index];
    return FadeAnimation(
        0.5,
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
                      Text(
                        item['orderState'],
                        style: TextStyle(
                            color: blackClr,
                            fontFamily: 'Baloo',
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Time Estimate ' + item['deliveryTime'] + ' minute',
                        style: TextStyle(fontFamily: 'Baloo', fontSize: 16),
                      ),
                      Text(
                        item['stateTime'],
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              )),
        ));
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
                    Text('Rs. ' + item['price'] + ' per item',
                        style: TextStyle(
                            color: blackClr,
                            fontFamily: 'Baloo',
                            fontSize: 18)),
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
