import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage>
    with SingleTickerProviderStateMixin {
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  bool isSearching = false;

  List items_data = [
    {
      'itemCode': '21',
      'itemTitle': 'Pespsi 1.5 Ltr',
      'price': '150',
      'unit': 'piece',
      'quantity': '0'
    },
    {
      'itemCode': '22',
      'itemTitle': 'Dalada Banaspati',
      'price': '180',
      'unit': 'liter',
      'quantity': '0'
    },
    {
      'itemCode': '23',
      'itemTitle': 'Sensodyn Toothpaste',
      'price': '230',
      'unit': 'piece',
      'quantity': '0'
    },
    {
      'itemCode': '24',
      'itemTitle': 'Surf Excel 1kg',
      'price': '530',
      'unit': '1 kg',
      'quantity': '0'
    },
    {
      'itemCode': '25',
      'itemTitle': 'Safe Guard Soap',
      'price': '60',
      'unit': 'piece',
      'quantity': '0'
    },
    {
      'itemCode': '26',
      'itemTitle': 'Lays Chips Small',
      'price': '20',
      'unit': 'piece',
      'quantity': '0'
    },
    {
      'itemCode': '27',
      'itemTitle': 'Dawn Bread',
      'price': '85',
      'unit': 'pack',
      'quantity': '0'
    },
    {
      'itemCode': '28',
      'itemTitle': 'Rice Kernal Banaspati',
      'price': '280',
      'unit': 'kg',
      'quantity': '0'
    },
    {
      'itemCode': '29',
      'itemTitle': 'Daal Mash',
      'price': '140',
      'unit': 'kg',
      'quantity': '0'
    },
    {
      'itemCode': '30',
      'itemTitle': 'Tissue Roll',
      'price': '45',
      'unit': 'piece',
      'quantity': '0'
    },
    {
      'itemCode': '31',
      'itemTitle': 'Tomato Katchup',
      'price': '150',
      'unit': 'bottle',
      'quantity': '0'
    },
    {
      'itemCode': '32',
      'itemTitle': 'Head & Shoulders Small',
      'price': '210',
      'unit': 'piece',
      'quantity': '0'
    }
  ];

  List filteredItems = List();

  @override
  void initState() {
    super.initState();
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
      // var resBody = json.decode(items_data.);
      setState(() {
        filteredItems = items_data;
      });
      return 'success';
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
        onPressed: () {},
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
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
}
