import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'Widgets/singup.dart';
import 'Widgets/textNew.dart';
import 'login_page.dart';
import 'package:google_fonts/google_fonts.dart';

final username = TextEditingController();
final password = TextEditingController();
final name = TextEditingController();
final age = TextEditingController();
final height = TextEditingController();
final weight = TextEditingController();

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final _formKey = GlobalKey<FormState>();
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SingUp(),
                      TextNew(),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter a valid Name';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: username,
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter a valid Username!';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter a valid password!';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: age,
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
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Age',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: height,
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
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Height (cm)',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: weight,
                        validator: (value) {
                          if (value == '' ||
                              (double.tryParse(value) != null) == false) {
                            return 'Please enter a valid weight!';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          labelText: 'Weight (Kg)',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, right: 0, left: 250),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: FlatButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            fetchPost(context);
                          }
                          // fetchPutCreateUser();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 30),
                    child: Container(
                      alignment: Alignment.topRight,
                      //color: Colors.red,
                      height: 20,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Have we met before?',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Linking to backend code

// Future<User> fetchPutCreateUser() async {
//   final response = await http.put(
//       'http://127.0.0.1:5000/users/?username=${username.text}&age=${age.text}&height=${height.text}&weight=${weight.text}&name=${name.text}');

//   if (response.statusCode == 200) {
//     // If the call to the server was successful (returns OK), parse the JSON.
//     return User.fromJson(json.decode(response.body));
//   } else {
//     // If that call was not successful (response was unexpected), it throw an error.
//     throw Exception('Failed to load put');
//   }
// }

Future<bool> fetchPost(BuildContext context) async {
  final checkres =
      await http.get('http://localhost:3333/users/?username=${username.text}');

  if (checkres.statusCode == 200) {
    //username exists
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Creation Unsuccessful', style: GoogleFonts.lora()),
          content: Text(
              'The username @' +
                  username.text +
                  ' already exists. Please retry!',
              style: GoogleFonts.lora()),
          actions: <Widget>[
            FlatButton(
              child: Text('OK!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return false;
  } else {
    final response = await http.post(
        'http://localhost:3333/users/?password=${password.text}&name=${name.text}&username=${username.text}');

    if (response.statusCode == 200) {
      // If the call to the server was successful (returns OK), parse the JSON.
      // return User.fromJson(json.decode(response.body));

      final response2 = await http.put(
          'http://localhost:3333/users/?username=${username.text}&age=${age.text}&height=${height.text}&weight=${weight.text}&name=${name.text}');

      if (response2.statusCode == 200) {
        // If the call to the server was successful (returns OK), parse the JSON.

        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Creation Successful!', style: GoogleFonts.lora()),
              content: Text(
                  'New User has been created! your username is @' +
                      username.text +
                      ' .',
                  style: GoogleFonts.lora()),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK!'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            );
          },
        );
        return true;
      } else {
        // If that call was not successful (response was unexpected), it throw an error.
        throw Exception('Failed to load put');
      }
    } else {
      // If that call was not successful (response was unexpected), it throw an error.
      throw Exception('Failed to load post');
    } //here
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
