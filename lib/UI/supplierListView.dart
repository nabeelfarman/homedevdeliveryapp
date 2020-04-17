import 'package:flutter/material.dart';
import 'package:homemobileapp/models/supplierModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../main.dart';

class SupplierListView extends StatefulWidget {
  final int value;
  final int userID;
  final int townID;
  final String searchText;
  SupplierListView({
    @required this.value,
    @required this.searchText,
    @required this.userID,
    @required this.townID,
  });
  @override
  _SupplierListViewState createState() => _SupplierListViewState(
      this.value, this.searchText, this.userID, this.townID);
}

class _SupplierListViewState extends State<SupplierListView> {
  int value;
  int userID;
  int townID;
  String searchText;

  _SupplierListViewState(
    this.value,
    this.searchText,
    this.userID,
    this.townID,
  );

  final List<SupplierModel> supplierList = [
    SupplierModel(1, "Save Mart", "G.T Road Branch G-15, Islamabad", 1, true),
    SupplierModel(1, "Madina Cash & Carry", "G-9 Markaz, Islamabad", 1, true),
    SupplierModel(1, "Habib Meat Shop", "Abpara Market, Islamabad", 4, true),
    SupplierModel(1, "Fresh Chicken Shop",
        "Sunday Bazaar near Peshawar Morre, Islamabad", 4, true),
    SupplierModel(1, "Khan Veges", "Abdullah Road, Islamabad", 2, true),
    SupplierModel(
        1, "Meri Fruite Shop", "Karachi Compnay Bus Stop, Islamabad", 3, true),
    SupplierModel(
        1, "Rana Fresh Friutes", "Karachi Company, Islamabad", 4, true),
    SupplierModel(
        1, "Islamabad Cash & Carry", "G-9 Markaz, Islamabad", 1, true),
    SupplierModel(
        1, "Khans Mutton Beaf Chicken", "G-10 Markaz, Islamabad", 4, true),
    SupplierModel(
        1, "Chaudhary Vegetables", "G-14/4 Street # 11, Islamabad", 2, true),
    SupplierModel(1, "Green Land Groceries", "F-11 Markaz, Islamabad", 1, true),
    SupplierModel(1, "Shaan Traders", "G-9 Markaz, Islamabad", 1, true),
    SupplierModel(1, "Home Traders", "G-9 Markaz, Islamabad", 1, true),
    SupplierModel(1, "Roshan Mart", "G-15 Markaz, Islamabad", 1, true),
  ];

  List<SupplierModel> filteredSupplier = [];
  ProgressDialog pr;

  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  @override
  void initState() {
    super.initState();

    // if (searchText != '') {
    //   filteredSupplier = supplierList
    //       .where((supplier) =>
    //           supplier.category == value &&
    //           supplier.title.toLowerCase().contains(searchText.toLowerCase()))
    //       .toList();
    // } else {
    //   filteredSupplier =
    //       supplierList.where((supplier) => supplier.category == value).toList();
    // }
    print(userID);
    print(townID);
  }

  Future<String> getMerchants() async {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    try {
      pr.show();
    } catch (e) {
      pr.hide();
      AlertDialog alert = AlertDialog(
        title: Text("Error!"),
        content: Text(e.toString()),
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
    // http://95.217.147.105:2001/api/getmerchantintown?TownID=1
  }

  void searchSupplier(String str) {
    // filteredSupplier = supplierList.where((supplier) =>
    // supplier.category == value &&
    // supplier.title.toLowerCase().contains(str.toLowerCase())).toList();

    // return filteredSupplier;
    // print(filteredSupplier);
    // print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
          itemCount: filteredSupplier.length,
          itemBuilder: (BuildContext context, int index) =>
              buildSupplierCard(context, index)),
    );
  }

  Widget buildSupplierCard(BuildContext context, int index) {
    final supplier = filteredSupplier[index];
    return GestureDetector(
      onTap: () {
        print(supplier.title);
        navigateToItems(context);
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(supplier.title,
                    style: TextStyle(
                        color: blackClr,
                        fontFamily: 'Baloo',
                        fontSize: 22,
                        fontWeight: FontWeight.w800)),
                FlatButton(
                  color: greenClr,
                  shape: CircleBorder(),
                  onPressed: () => {},
                  child: Text('A'),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(supplier.address,
                    style: TextStyle(
                        color: blackClr, fontFamily: 'Baloo', fontSize: 16))
              ],
            )
          ],
        ),
      )),
    );
  }

  void navigateToItems(BuildContext context) {
    Routes.sailor.navigate('/item');
  }
}
