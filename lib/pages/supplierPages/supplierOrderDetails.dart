import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:intl/intl.dart';

class SupplierOrderDetails extends StatefulWidget {
  final String orderNo;
  final String customer;
  final String address;
  final List orderStatus;
  final List cartItems;
  const SupplierOrderDetails(
      {Key key,
      this.orderNo,
      this.customer,
      this.address,
      this.orderStatus,
      this.cartItems})
      : super(key: key);

  @override
  _SupplierOrderDetailsState createState() => _SupplierOrderDetailsState();
}

class _SupplierOrderDetailsState extends State<SupplierOrderDetails>
    with SingleTickerProviderStateMixin {
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  String orderNo = '2120';
  String customer = 'Haroon Qadeer';
  String address = 'House No. 19, Street No. 18, E-16/3, Islamabad';
  final formatter = new NumberFormat('##,###.##');
  double totalAmount = 0;

  List orderStatus = [
    {
      'orderState': 'place order',
      'deliveryTime': '10:00',
      'stateTime': '12:00 pm'
    },
    {
      'orderState': 'supplier estimates',
      'deliveryTime': '20:00',
      'stateTime': '12:05 pm'
    },
    {
      'orderState': 'acknowledgement',
      'deliveryTime': '-',
      'stateTime': '12:10 pm'
    }
  ];

  List cartItems = [
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

  @override
  void initState() {
    super.initState();
    this.shoppingSum();
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
          title: Text('Order No. ' + orderNo + ' Detail',
              style: TextStyle(
                  color: blackClr, fontFamily: 'Josefin', fontSize: 25))),
      body: SingleChildScrollView(
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
                            color: Colors.grey,
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
                          onPressed: () => {},
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
                          onPressed: () => {},
                          elevation: 5,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 5, 20, 5),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10)),
                          color: greenClr,
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
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
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
      )),
    );
  }

  Widget buildOrderStatusCard(BuildContext context, int index) {
    final item = orderStatus[index];
    return FadeAnimation(
        0.5,
        Card(
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
                        color: blackClr, fontFamily: 'Baloo', fontSize: 18)),
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
