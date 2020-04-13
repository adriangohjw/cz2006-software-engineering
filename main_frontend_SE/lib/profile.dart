import 'dart:convert';
import 'package:bicycle/changepassword.dart';
import 'package:flutter/material.dart';
import 'edituser.dart';
import 'netStatistics.dart';
import 'savedMaps.dart';
import 'package:http/http.dart' as http;
class DataUser {

  String username;
  DataUser({this.username});
}
final dataUser = DataUser(username: username);
class ProfilePage extends StatefulWidget {
  int id;
  var PersDet;
  ProfilePage({@required this.id, @required this.PersDet});
  _ProfilePageState createState() => _ProfilePageState(userid: id,details: PersDet);
}
var username;
class _ProfilePageState extends State<ProfilePage> {
  int userid;
  var details;
  _ProfilePageState({@required this.userid, @required this.details});
  var pastRoutes;
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
              onPressed: () async{
                dataUser.username = await username;
                Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditUser(dataUser: dataUser,)),
                    );
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
              onPressed: () async{
                dataUser.username = await username;
                Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditPassword(dataUser: dataUser,)),
                    );
              },
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
                onPressed: () async{
                  await getPastRoutes();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SavedMap(id: userid,pastroutes: pastRoutes,)),
                    );},
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Past Rides',
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

getPastRoutes() async {
  //print('entered');
  
  var response1 = await http.get('http://localhost:3333/users/id/?id='+userid.toString());
  if (response1.statusCode==200)
  {
  pastRoutes = await (json.decode(response1.body))['routes'];
  username = await (json.decode(response1.body))['username'];
  } else{
    throw Exception('Failed to load routes');
  }

  // final response1 =
  //     await http.get('http://localhost:3333/users/?username=${uname}');
  
  
  // if (response1.statusCode == 200) {
  //   weight = await (json.decode(response1.body))['weight'];
  //   final responsepass = await http.get(
  //       'http://localhost:3333/users/auth/?username=${uname}&password=${pcode}');
  //   if (responsepass.statusCode == 200) {
  //     bool pass = (json.decode(responsepass.body))['result'];

  //     if (pass == true) {
  //       print('login succesful');
  //       loginfail = false;
  //       final response3 = await http.get(
  //     'http://localhost:3333/algo/popular_routes/?weight=' + weight.toString());
  //       //setState(() => loading = true);
  //       data.id = (json.decode(response1.body))['id'];
  //       print((json.decode(response1.body))['username']);
  //       print((json.decode(response1.body))['name']);
  //       print((json.decode(response1.body))['age']);
  //       print((json.decode(response1.body))['height']);
  //       print((json.decode(response1.body))['weight']);
  //       userdetails.add((json.decode(response1.body))['username']);
  //       userdetails.add((json.decode(response1.body))['name']);
  //       userdetails.add((json.decode(response1.body))['age']);
  //       userdetails.add((json.decode(response1.body))['height']);
  //       userdetails.add((json.decode(response1.body))['weight']);
  //       routes = (json.decode(response3.body));
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => MyHomePage(
  //                     id: data.id, profDetails: userdetails, popRoutes: routes,
  //                   )));
  //     } else {
  //       loginfail = true;
  //               print("Username or Password is wrong");

  //       return false;
  //     }
  //   }
    
  // } else {
  //   loginfail = true;

  //   print('Username or Password is wrong');
  //   return false;
  // }
  // return true;
  
}

}
