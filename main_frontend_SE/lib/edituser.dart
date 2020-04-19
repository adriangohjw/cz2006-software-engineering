import 'package:bicycle/SearchResults.dart';
import 'package:bicycle/login_page.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'profile.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditUser extends StatefulWidget {
  var details;
  var poproutes;
  EditUser({@required this.details, @required this.poproutes});
  //print(this.dataUser);

  //@override
  _EditUserState createState() =>
      _EditUserState(initusername: details, popRo: poproutes);
}

class _EditUserState extends State<EditUser> {
  var username = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var age = TextEditingController();
  var height = TextEditingController();
  var weight = TextEditingController();
  Future<User> post;
  var initusername;
  var popRo;
  _EditUserState({@required this.initusername, @required this.popRo});

  @override
  void initState() {
    super.initState();
    post = fetchPost(initusername[0]);
  }

  final _formKey = GlobalKey<FormState>();

  String curusername;
  String curname;
  String curage;
  String curheight;
  String curweight;

  @override
  Widget build(BuildContext context) {
    username.text = initusername[0].toString();
    if (curname == null) {
      name.text = initusername[1].toString();
    } else {
      name.text = curname;
    }

    if (curage == null) {
      age.text = initusername[2].toString();
    } else {
      age.text = curage;
    }

    if (curheight == null) {
      height.text = initusername[3].toString();
    } else {
      height.text = curheight;
    }

    if (curweight == null) {
      weight.text = initusername[4].toString();
    } else {
      weight.text = curweight;
    }

    //username.text = initusername.name;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, Colors.black]),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(40, 60, 20, 0),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: new TextEditingController.fromValue(
                          new TextEditingValue(
                            text: name.text,
                            selection: new TextSelection.collapsed(
                              offset: name.text.length,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter your Name!';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        onChanged: (value) {
                          if (value == '') {
                            curname = null;
                            name.text = null;
                          } else {
                            curname = value;
                            name.text = value;
                            name.selection = TextSelection.collapsed(
                                offset: name.text.length);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: new TextEditingController.fromValue(
                          new TextEditingValue(
                            text: age.text,
                            selection: new TextSelection.collapsed(
                              offset: age.text.length,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == '' ||
                              (int.tryParse(value) != null) == false) {
                            return 'Please enter a valid age!';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Age',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        onChanged: (value) {
                          if (value == '') {
                            curage = null;
                            age.text = null;
                          } else {
                            curage = value;
                            age.text = value;
                            age.selection = TextSelection.collapsed(
                                offset: age.text.length);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: new TextEditingController.fromValue(
                          new TextEditingValue(
                            text: height.text,
                            selection: new TextSelection.collapsed(
                              offset: height.text.length,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == '' ||
                              (double.tryParse(value) != null) == false) {
                            return 'Please enter a valid Height!';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Height',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        onChanged: (value) {
                          if (value == '') {
                            curheight = null;
                            height.text = null;
                          } else {
                            curheight = value;
                            height.text = value;
                            height.selection = TextSelection.collapsed(
                                offset: height.text.length);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value == '' ||
                              (double.tryParse(value) != null) == false) {
                            return 'Please enter a valid weight!';
                          }
                          return null;
                        },
                        controller: new TextEditingController.fromValue(
                          new TextEditingValue(
                            text: weight.text,
                            selection: new TextSelection.collapsed(
                              offset: weight.text.length,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Weight',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        onChanged: (value) {
                          if (value == '') {
                            curweight = null;
                            weight.text = null;
                          } else {
                            curweight = value;
                            weight.text = value;
                            weight.selection = TextSelection.collapsed(
                                offset: weight.text.length);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Back',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
                            ),
                          ),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await fetchPut(username.text, age.text,
                                  height.text, weight.text, name.text);
                              List l = await getDet(username.text);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                          id: l[0],
                                          profDetails: l[1],
                                          popRoutes: popRo,
                                        )),
                              );
                            }
                          },
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Save!',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
                            ),
                          ),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// connecting to back end

Future fetchPut(
    String uname, String agee, String ht, String wt, String nm) async {
  final response = await http.put(
      'http://localhost:3333/users/?username=${uname}&age=${agee}&height=${ht}&weight=${wt}&name=${nm}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    //return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load put');
  }
}

Future<User> fetchPost(String usrname) async {
  final response =
      await http.get('http://localhost:3333/users/?username=${usrname}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    // name.text = json.decode(response.body)['username'];
    // age.text = json.decode(response.body)['age'];
    // height.text = json.decode(response.body)['height'];
    // weight.text = json.decode(response.body)['weight'];

    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}

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
