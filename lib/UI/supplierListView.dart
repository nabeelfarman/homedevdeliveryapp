import 'package:flutter/material.dart';
import 'package:homemobileapp/models/supplierModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';

class SupplierListView extends StatefulWidget {
  final int value;
  final int userID;
  final int townID;
  final String searchText;
  final List supplierList;

  SupplierListView({
    @required this.value,
    @required this.searchText,
    @required this.userID,
    @required this.townID,
    @required this.supplierList,
  });
  @override
  _SupplierListViewState createState() => _SupplierListViewState(
        this.value,
        this.searchText,
        this.userID,
        this.townID,
        this.supplierList,
      );
}

class _SupplierListViewState extends State<SupplierListView> {
  int value;
  int userID;
  int townID;
  String searchText;
  List supplierList;
  int supplierID;

  _SupplierListViewState(
    this.value,
    this.searchText,
    this.userID,
    this.townID,
    this.supplierList,
  );

  List filteredSupplier = [];
  ProgressDialog pr;

  Color blackClr = Color(0xff1D2028);

  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ffA3C12E);
  Color redClr = Color(0x0ffcf3f3d);

  Color yellowClr = Color(0x0ffF8D247);
  Color darkYellowClr = Color(0x0ffdfbd3f);
  Color lightYellowClr = Color(0x0ffffde22);

  @override
  void initState() {
    super.initState();
    // getMerchants();
    if (searchText != '') {
      filteredSupplier = supplierList
          .where((supplier) =>
              supplier["category"] == value &&
              supplier["title"]
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
          .toList();
    } else {
      filteredSupplier = supplierList
          .where((supplier) => supplier["category"] == value)
          .toList();
    }
    print(userID);
    print(townID);
  }

  // Future<String> getMerchants() async {
  //   Widget okButton = FlatButton(
  //     child: Text("OK"),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );
  //   try {
  //     // pr.show();

  //     var response = await http.get(
  //         "http://95.217.147.105:2001/api/getmerchantintown?TownID=" +
  //             townID.toString(),
  //         headers: {
  //           "Content-Type": "application/json",
  //         });
  //     var responseJson = json.decode(response.body);

  //     for (int i = 0; i < responseJson.length; i++) {
  //       supplierList.add({
  //         'id': responseJson[i]["merchantID"],
  //         'title': responseJson[i]["companyName"],
  //         'address': responseJson[i]["townName"],
  //         'category': responseJson[i]["businessID"],
  //         'active': true,
  //       });
  //     }

  //     print(supplierList.length);

  //     // filteredSupplier = [];
  //     // for (int i = 0; i < responseJson.length; i++) {
  //     //   if (value == responseJson[i]["businessID"]) {
  //     //     filteredSupplier.add({
  //     //       'id': responseJson[i]["merchantID"],
  //     //       'title': responseJson[i]["companyName"],
  //     //       'address': responseJson[i]["townName"],
  //     //       'category': responseJson[i]["businessID"],
  //     //       'active': true,
  //     //     });
  //     //   }
  //     // }

  //     filteredSupplier = supplierList
  //         .where((supplier) =>
  //             supplier["category"] == value &&
  //             supplier['title']
  //                 .toLowerCase()
  //                 .contains(searchText.toLowerCase()))
  //         .toList();

  //     print(filteredSupplier);

  //     // pr.hide();
  //   } catch (e) {
  //     // pr.hide();
  //     AlertDialog alert = AlertDialog(
  //       title: Text("Error!"),
  //       content: Text(e.toString()),
  //       actions: [
  //         okButton,
  //       ],
  //     );
  //     // show the dialog
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return alert;
  //       },
  //     );
  //   }
  //   // http://95.217.147.105:2001/api/getmerchantintown?TownID=1
  // }

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
        supplierID = supplier["id"];
        // print(value);
        // print(supplierID);
        // print(userID);
        navigateToItems(context);
      },
      child: Card(
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
                    Text(supplier["title"],
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
                    Text(supplier["address"],
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
    Routes.sailor.navigate(
      '/item',
      params: {
        'supplierID': supplierID,
        'userID': userID,
        'businessID': value,
      },
    );
  }
}
