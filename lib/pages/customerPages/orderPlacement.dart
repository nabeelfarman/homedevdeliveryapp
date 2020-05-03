import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:edge_alert/edge_alert.dart';
import '../../main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class OrderPlacement extends StatefulWidget {
  final int supplierID;
  final int customerID;
  final String companyName;
  final double totalAmount;

  @override
  OrderPlacement({
    @required this.supplierID,
    @required this.customerID,
    @required this.companyName,
    @required this.totalAmount,
  });

  @override
  _OrderPlacementState createState() => _OrderPlacementState(
        this.supplierID,
        this.customerID,
        this.companyName,
        this.totalAmount,
      );
}

class _OrderPlacementState extends State<OrderPlacement> {
  Color blackClr = Color(0xff1D2028);

  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ffA3C12E);
  Color redClr = Color(0x0ffcf3f3d);

  Color yellowClr = Color(0x0ffF8D247);
  Color darkYellowClr = Color(0x0ffdfbd3f);
  Color lightYellowClr = Color(0x0ffffde22);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  int customerID;
  int supplierID;
  String companyName;
  double totalAmount;

  int userID;
  String userName;
  int appTypeID;
  String email;
  int townID;
  final formatter = new NumberFormat('##,###.##');
  double orderNo = 1735;

  ProgressDialog pr;

  _OrderPlacementState(
    this.supplierID,
    this.customerID,
    this.companyName,
    this.totalAmount,
  );

  @override
  void initState() {
    super.initState();
    print(supplierID);
    this.getUserData();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) {
    debugPrint("payload: $payload");
    showSuccessMsg();
  }

  showNotification(String id, String notify, String message) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'channel Description');
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.show(0, notify, message, platform);
  }

  @override
  Future<String> getUserData() async {
    try {
      Future.delayed(Duration(seconds: 1)).then((value) {
        pr.show();
      });
      var response = await http.get(
          "http://95.217.147.105:2001/api/getuserdetail?UserID=" +
              customerID.toString(),
          headers: {
            "Content-Type": "application/json",
          });
      var responseJson = json.decode(response.body);

      userID = responseJson[0]["userID"];
      userName = responseJson[0]["userName"];
      appTypeID = responseJson[0]["appTypeID"];
      email = responseJson[0]["email"];
      townID = responseJson[0]["townID"];

      Future.delayed(Duration(seconds: 2)).then((value) {
        pr.hide();
      });

      return 'success';
    } catch (e) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        pr.hide();
      });

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
      pr.show();

      var now = new DateTime.now();
      // print(now);
      String currentDate = new DateFormat("yyyy-MM-dd").format(now).toString();
      // print(currentDate);
      // print(customerID);

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
      // var responseJson;

      if (responseJson["msg"] == "Success") {
        pr.hide();
        print('Success');
        generateNotification();
        navigateToSideBarLayout(context);
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

  void generateNotification() async {
    try {
      var response = await http.get(
          "http://95.217.147.105:2001/api/getuserdetail?UserID=" +
              supplierID.toString(),
          headers: {
            "Content-Type": "application/json",
          });
      var responseJson = json.decode(response.body);
      String mobile;

      mobile = responseJson[0]["cellNo"].toString();

      showNotification(mobile, 'Order Placed', "Order Placed by " + userName);
    } catch (e) {
      print(e);
    }
  }

  void showSuccessMsg() async {
    EdgeAlert.show(
      context,
      title: "Your order is placed successfully!",
      // description: 'Description',
      gravity: EdgeAlert.TOP,
      icon: Icons.check,
      backgroundColor: blackClr,
    );
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
          centerTitle: true,
          elevation: 0,
          backgroundColor: darkYellowClr,
          title: Text('Order Placement',
              style: TextStyle(
                  color: blackClr, fontFamily: 'Anton', fontSize: 25)),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back), onPressed: () {}, color: blackClr)
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
            // color: yellowClr,
            gradient: new LinearGradient(
                colors: [darkYellowClr, lightYellowClr, yellowClr],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 120.0,
                width: 120.0,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('assets/images/orderPlacement.png'),
                    // fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 20,
                            fontFamily: 'Baloo',
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'Please, process your order',
                                style: new TextStyle(color: blackClr)),
                            // new TextSpan(
                            //     text: 'Order No. ' + orderNo.toString(),
                            //     style: TextStyle(
                            //         color: redClr,
                            //         fontWeight: FontWeight.w900)),
                            new TextSpan(
                                text: ' from ',
                                style: TextStyle(color: blackClr)),
                            new TextSpan(
                                text: 'M/s ' + companyName,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: redClr)),
                            new TextSpan(
                                text: ' of total amount ',
                                style: new TextStyle(color: blackClr)),
                            new TextSpan(
                                text: 'Rs. ' +
                                    formatter.format(totalAmount).toString(),
                                style: new TextStyle(
                                    color: redClr, fontWeight: FontWeight.w900))
                          ]))),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  // color: blackClr,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10),
                      color: blackClr),
                  child: Text(
                    'Payment through Cash on delivery',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Baloo', fontSize: 20, color: whiteClr),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: redClr,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      genOrder();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Place Order',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Baloo', color: whiteClr, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
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
