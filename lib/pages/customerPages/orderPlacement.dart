import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPlacement extends StatefulWidget {
  @override
  _OrderPlacementState createState() => _OrderPlacementState();
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
                                text: 'Please, process your ',
                                style: new TextStyle(color: blackClr)),
                            new TextSpan(
                                text: 'Order No. ' + orderNo.toString(),
                                style: TextStyle(
                                    color: redClr,
                                    fontWeight: FontWeight.w900)),
                            new TextSpan(
                                text: ' from ',
                                style: TextStyle(color: blackClr)),
                            new TextSpan(
                                text: 'M/s ' + supplier,
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
          ),
        ));
  }
}
