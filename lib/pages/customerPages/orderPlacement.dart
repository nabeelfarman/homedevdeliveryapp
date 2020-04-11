import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPlacement extends StatefulWidget {
  @override
  _OrderPlacementState createState() => _OrderPlacementState();
}

class _OrderPlacementState extends State<OrderPlacement> {
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  String supplier = 'Save Mart';
  String address = 'G.T Road near G-15 Islamabad';
  double totalAmount = 20345;
  final formatter = new NumberFormat('##,###.##');
  double orderNo = 1735;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: whiteClr,
          title: Text('Order Placement',
              style: TextStyle(
                  color: blackClr, fontFamily: 'Josefin', fontSize: 25)),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back), onPressed: () {}, color: redClr)
          ],
        ),
        body: new Column(
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
                              text: 'Please, process your ',
                              style: new TextStyle(color: blackClr)),
                          new TextSpan(
                              text: 'Order No. ' + orderNo.toString(),
                              style: TextStyle(
                                  color: redClr, fontWeight: FontWeight.w900)),
                          new TextSpan(
                              text: ' from ',
                              style: TextStyle(color: blackClr)),
                          new TextSpan(
                              text: 'M/s ' + supplier,
                              style: new TextStyle(
                                  fontWeight: FontWeight.w900, color: redClr)),
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
                color: greenClr,
                child: Text(
                  'Payment through Cash on delivery',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Baloo', fontSize: 20),
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
                  onPressed: () {},
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
        ));
  }
}
