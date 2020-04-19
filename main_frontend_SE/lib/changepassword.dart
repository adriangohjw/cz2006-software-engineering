import 'package:bicycle/SearchResults.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'profile.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final username = TextEditingController();
final newpassword = TextEditingController();
final oldpassword = TextEditingController();
bool passwrong = false;

class EditPassword extends StatefulWidget {
  //@override
  var dataUser;
  var pop;
  EditPassword({@required this.dataUser, @required this.pop});

  //@override
  _EditPasswordState createState() => _EditPasswordState(initdeets: dataUser, pops: pop);
}

class _EditPasswordState extends State<EditPassword> {
  Future<User> post;
  var username = TextEditingController();
  var initdeets;
  var pops;
  _EditPasswordState({@required this.initdeets, @required this.pops});
  @override
  void initState() {
    super.initState();
    post = fetchPost(initdeets[0].toString());
  }


  @override
  Widget build(BuildContext context) {
    
    username.text = initdeets[0].toString();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, Colors.black]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(40, 60, 20, 0),
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      obscureText: true,
                      controller: oldpassword,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.white,
                        labelText: 'Old Password',
                        errorText: passwrong ? 'Old Password Incorrect' : null,
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      obscureText: true,
                      controller: newpassword,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.white,
                        labelText: 'New Password',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Back',
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          bool checks = await fetchPutPassword(username.text);
                          if (checks) {
                            List l = await getDet(username.text);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                  id: l[0],
                                  profDetails: l[1],
                                  popRoutes: pops,
                                ),
                              ),
                            );
                          } else {
                            passwrong = true;
                          }
                        },
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Save!',
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                      )
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// connecting to back end
Future<List> getDet(String uname) async {
  var personDet = [];
  var userID;
  var l = [];
  var response1 =
      await http.get('http://localhost:3333/users/?username=${uname}');
  if (response1.statusCode == 200) {
    personDet.add((await json.decode(response1.body))['username']);
    personDet.add((await json.decode(response1.body))['name']);
    personDet.add((await json.decode(response1.body))['age']);
    personDet.add((await json.decode(response1.body))['height']);
    personDet.add((await json.decode(response1.body))['weight']);
    userID = await (json.decode(response1.body))['id'];
    l.add(userID);
    l.add(personDet);
    return l;
  } else {
    throw Exception('Failed to load details');
  }
  // l.add(userID);
  // l.add(personDet);
  // return l;
}

Future<bool> fetchPutPassword(String uname) async {
  final response = await http.put(
      'http://localhost:3333/users/password/?username=${uname}&current_password=${oldpassword.text}&new_password=${newpassword.text}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    //return User.fromJson(json.decode(response.body));
    return true;
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    return false;
    throw Exception('Failed to load put');
  }
}

Future<User> fetchPost(String uname) async {
  final response =
      await http.get('http://localhost:3333/users/?username=${uname}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load get');
  }
}

class User {
  final String name;
  final String username;
  final int id;
  final int age;
  final int weight;
  final int height;
  final String password;

  User(
      {this.id,
      this.name,
      this.username,
      this.password,
      this.age,
      this.height,
      this.weight});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}
