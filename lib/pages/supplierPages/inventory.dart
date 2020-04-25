import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/supplier_bottom_bar.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
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

  bool isSearching = false;

  List items_data = [
    {
      'itemCode': '21',
      'itemTitle': 'Pespsi 1.5 Ltr',
      'price': '150',
      'unit': 'piece',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '22',
      'itemTitle': 'Dalada Banaspati',
      'price': '180',
      'unit': 'liter',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '23',
      'itemTitle': 'Sensodyn Toothpaste',
      'price': '230',
      'unit': 'piece',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '24',
      'itemTitle': 'Surf Excel 1kg',
      'price': '530',
      'unit': '1 kg',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '25',
      'itemTitle': 'Safe Guard Soap',
      'price': '60',
      'unit': 'piece',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '26',
      'itemTitle': 'Lays Chips Small',
      'price': '20',
      'unit': 'piece',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '27',
      'itemTitle': 'Dawn Bread',
      'price': '85',
      'unit': 'pack',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '28',
      'itemTitle': 'Rice Kernal Banaspati',
      'price': '280',
      'unit': 'kg',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '29',
      'itemTitle': 'Daal Mash',
      'price': '140',
      'unit': 'kg',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '30',
      'itemTitle': 'Tissue Roll',
      'price': '45',
      'unit': 'piece',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '31',
      'itemTitle': 'Tomato Katchup',
      'price': '150',
      'unit': 'bottle',
      'quantity': '0',
      'mol': '0'
    },
    {
      'itemCode': '32',
      'itemTitle': 'Head & Shoulders Small',
      'price': '210',
      'unit': 'piece',
      'quantity': '0',
      'mol': '0'
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
                    Text('Rs.  ',
                        style: TextStyle(
                            color: redClr, fontFamily: 'Baloo', fontSize: 18)),
                    Flexible(
                        child: TextFormField(
                      key: Key('price'),
                      decoration: InputDecoration(
                        hintText: 'price',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: redClr)),
                      ),
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    )),
                    Text('  Quantity:  ',
                        style: TextStyle(
                            color: redClr, fontFamily: 'Baloo', fontSize: 18)),
                    Flexible(
                        child: TextFormField(
                      key: Key('quantity'),
                      decoration: InputDecoration(
                        hintText: 'quantity',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: redClr)),
                      ),
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    )),
                    Text('  ' + item['unit'] + '   ',
                        style: TextStyle(
                            color: redClr, fontFamily: 'Baloo', fontSize: 18)),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
