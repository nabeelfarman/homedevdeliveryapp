import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';

class ContactInfo extends StatefulWidget {
  @override
  _ContactInfo createState() => _ContactInfo();
}

class _ContactInfo extends State<ContactInfo> {
  _ContactInfo();

  //declarations
  Color blackClr = Color(0xff141622);
  Color greenClr = Color(0xff8cc540);
  Color blueClr = Color(0xff408cc5);
  Color bodyClr = Color(0xfff8f7f7);

  //dropdown lists
  List<DropdownMenuItem<int>> listProvince = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: bodyClr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Material(
            elevation: 10,
            child: FadeAnimation(
                1.0,
                Container(
                  height: 80,
                  alignment: Alignment.bottomCenter,
                  color: blackClr,
                  child: Text(
                    'Registration',
                    style: TextStyle(
                        color: greenClr, fontSize: 40, fontFamily: 'Abel'),
                  ),
                )),
          ),
          FadeAnimation(
            1.5,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Contact Information',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: blueClr,
                        fontSize: 30,
                        fontFamily: 'Abel',
                        fontWeight: FontWeight.bold)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 50, right: 50),
                    child: DropdownButton(
                        isExpanded: true,
                        items: null,
                        hint: new Text('select province'),
                        onChanged: null)),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: DropdownButton(
                      isExpanded: true,
                      items: null,
                      hint: new Text('select district'),
                      onChanged: null),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: DropdownButton(
                        isExpanded: true,
                        items: null,
                        hint: new Text('select city'),
                        onChanged: null)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: DropdownButton(
                        isExpanded: true,
                        items: null,
                        hint: new Text('select tehsil'),
                        onChanged: null)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: DropdownButton(
                        isExpanded: true,
                        items: null,
                        hint: new Text('select town'),
                        onChanged: null)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintMaxLines: 4, hintText: 'contact address'),
                    )),
              ],
            ),
          ),
          FadeAnimation(
            2.0,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0),
                  ),
                  splashColor: blackClr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_back, color: greenClr),
                      ),
                      Text(
                        "Back",
                        style: TextStyle(
                          color: greenClr,
                          fontSize: 20,
                          fontFamily: 'Abel',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
                Container(
                  width: 100,
                  height: 30,
                  //color: Colors.orangeAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            //color: blueClr,
                            shape: BoxShape.circle,
                            border: Border.all(color: blueClr)),
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //color: blueClr,
                            border: Border.all(color: blueClr)),
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //color: blueClr,
                            border: Border.all(color: blueClr)),
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //color: blueClr,
                            border: Border.all(color: blueClr)),
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: blueClr,
                            border: Border.all(color: blueClr)),
                      )
                    ],
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0),
                  ),
                  splashColor: blackClr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Next",
                        style: TextStyle(
                          color: greenClr,
                          fontSize: 20,
                          fontFamily: 'Abel',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.arrow_forward, color: greenClr),
                      )
                    ],
                  ),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}