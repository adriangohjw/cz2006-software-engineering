import 'package:flutter/material.dart';
import 'edituser.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
          Center(
              child: Container(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 5),
            child: Text("Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 30,
                    letterSpacing: 1.0)),
          )),
          new Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Text("System",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins-Bold",
                        fontSize: 30,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold)),
              )),
          new Container(
            height: 2,
            width: 1000,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("Username",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("@username",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0))),
            ],
          ),
          SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return EditUser();
                }), ModalRoute.withName('/'));
              },
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
            RaisedButton(
              onPressed: () {},
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Password Reset',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            )
          ]),
          SizedBox(height: 40),
          new Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Text("User",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins-Bold",
                        fontSize: 30,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold)),
              )),
          new Container(
            height: 2,
            width: 1000,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("Janice Tan",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0))),
            ],
          ),
          new Container(
            height: 2,
            width: 1000,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 20.0, top: 10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                // Statistics
                onPressed: () {},
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Statistics',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              RaisedButton(
                // Saved Rides
                onPressed: () {},
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Saved Rides',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
            ],
          ),
          new Container(
            height: 2,
            width: 1000,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("Age",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("21",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0))),
            ],
          ),
          new Container(
            height: 2,
            width: 1000,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("Height",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("155cm",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0))),
            ],
          ),
          new Container(
            height: 2,
            width: 1000,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("Weight",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("55kg",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                          letterSpacing: 1.0))),
            ],
          ),
          new Container(
            height: 2,
            width: 1000,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
          ),
        ])));
  }
}
