import 'package:flutter/material.dart';
import 'edituser.dart';
import 'netStatistics.dart';
import 'savedMaps.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  int id;
  var PersDet;
  ProfilePage({@required this.id, @required this.PersDet});
  _ProfilePageState createState() => _ProfilePageState(userid: id,details: PersDet);
}

class _ProfilePageState extends State<ProfilePage> {
  int userid;
  var details;
  _ProfilePageState({@required this.userid, @required this.details});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                  child: Text("@"+details[0].toString(),
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
                  child: Text(details[1].toString(),
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
                onPressed: () {Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NetStats()),
                    );},
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
                onPressed: () {Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SavedMap()),
                    );},
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
                  child: Text(details[2].toString(),
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
                  child: Text(details[3].toString(),
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
                  child: Text(details[4].toString(),
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
        ]))));
  }
}
