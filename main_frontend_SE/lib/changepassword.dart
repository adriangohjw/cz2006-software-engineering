import 'package:flutter/material.dart';
import 'profile.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final username = TextEditingController();
final newpassword = TextEditingController();
final oldpassword = TextEditingController();

class EditPassword extends StatefulWidget {
  @override
  final DataUser dataUser;
  EditPassword({this.dataUser});

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  Future<User> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: username,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.lightBlueAccent,
                        labelText: 'Username',
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
                      controller: oldpassword,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.lightBlueAccent,
                        labelText: 'Old Password',
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
                        border: InputBorder.none,
                        fillColor: Colors.lightBlueAccent,
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
                          fetchPutPassword();
                          List l= await getDet();
                          Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ProfilePage(id: l[0], PersDet: l[1],)),
                    );
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
Future<List> getDet() async {  
  var personDet=[];
  var userID;
  var l=[];
  var response1 = await http.get('http://localhost:3333/users/?username='+dataUser.username);
  if (response1.statusCode==200)
  {
  personDet.add(( await json.decode(response1.body))['username']);
  personDet.add(( await json.decode(response1.body))['name']);
  personDet.add(( await json.decode(response1.body))['age']);
  personDet.add(( await json.decode(response1.body))['height']);
  personDet.add(( await json.decode(response1.body))['weight']);
  userID = await ( json.decode(response1.body))['id'];
  l.add(userID);
  l.add(personDet);
  return l;
  } else{
    throw Exception('Failed to load details');
  }
  // l.add(userID);
  // l.add(personDet);
  // return l;
}

Future<User> fetchPutPassword() async {
  final response = await http.put(
      'http://127.0.0.1:5000/users/password/?username=${username.text}&current_password=${oldpassword.text}&new_password=${newpassword.text}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}

Future<User> fetchPost() async {
  final response = await http
      .get('http://127.0.0.1:5000/users/?username=${dataUser.username}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
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