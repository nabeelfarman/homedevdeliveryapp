import 'package:flutter/material.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:homemobileapp/UI/supplierListView.dart';
import 'package:homemobileapp/models/categoryModel.dart';
import 'package:homemobileapp/navigationBloc/navigationBlock.dart';

class NewOrderPage extends StatefulWidget with NavigationStates {
  final int userID;
  final int townID;

  @required
  NewOrderPage({
    @required this.userID,
    @required this.townID,
  });

  @override
  _NewOrderPageState createState() => _NewOrderPageState(
        userID,
        townID,
      );
}

class _NewOrderPageState extends State<NewOrderPage>
    with SingleTickerProviderStateMixin {
  int userID;
  int townID;

  _NewOrderPageState(
    this.userID,
    this.townID,
  );

  //declaration
  String pageName = 'newOrder';
  List tempList = [];

  final List<CategoryModel> categoryList = [
    CategoryModel(1, 'Grocery'),
    CategoryModel(2, 'Vegetable'),
    CategoryModel(3, 'Fruit'),
    CategoryModel(4, 'Meat')
  ];
  TabController _tabController;
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  bool isSearching = false;
  SupplierListView supplierListPage;

  // GlobalKey<SupplierListView> _supplierState = GlobalKey();
  @override
  void initState() {
    super.initState();

    _tabController =
        new TabController(length: categoryList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: whiteClr,
        title: !isSearching
            ? Text('Home Delivery',
                style: TextStyle(
                    color: blackClr, fontFamily: 'Josefin', fontSize: 25))
            : TextField(
                onChanged: (Text) {
                  // supplierListPage.prinText(value);
                  // _tabController.animateTo(_tabController.index);
                  setState(() {
                    // supplierListPage = SupplierListView(
                    //   value: _tabController.index + 1,
                    //   searchText: Text,
                    // );
                    // supplierListPage.prinText(Text);
                    // supplierListPage.prinText(Text);
                  });
                },
                style: TextStyle(color: redClr),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: redClr,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: redClr)),
                    hintText: 'search supplier',
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
        // padding: EdgeInsets.only(left: 20),
        children: <Widget>[
          SizedBox(
              height: 40.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Text(
                  'Categories',
                  style: TextStyle(
                      color: blackClr,
                      fontFamily: 'Ubuntu',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              )),
          Material(
            elevation: 1.0,
            child: Container(
              color: whiteClr,
              child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: whiteClr,
                  labelStyle: TextStyle(
                      fontFamily: 'Baloo',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                  unselectedLabelColor: redClr,
                  unselectedLabelStyle: TextStyle(
                      fontFamily: 'Baloo',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), color: redClr),
                  tabs: categoryList.map((category) {
                    return Tab(
                      key: Key('category_' + category.id.toString()),
                      text: category.title,
                      //icon: Icon(getMaterialIcon(name: category.icon)),
                    );
                  }).toList()),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                supplierListPage = SupplierListView(
                  value: 1,
                  searchText: '',
                  userID: userID,
                  townID: townID,
                ),
                supplierListPage = SupplierListView(
                  value: 2,
                  searchText: '',
                  userID: userID,
                  townID: townID,
                ),
                supplierListPage = SupplierListView(
                  value: 3,
                  searchText: '',
                  userID: userID,
                  townID: townID,
                ),
                supplierListPage = SupplierListView(
                  value: 4,
                  searchText: '',
                  userID: userID,
                  townID: townID,
                )
              ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(
        pageName,
        tempList,
      ),
    );
  }
}
