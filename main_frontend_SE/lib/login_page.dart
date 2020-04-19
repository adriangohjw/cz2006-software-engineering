import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'new_user.dart';
import 'profile.dart';
import 'util/screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'loadingPage.dart';

//import '.././util/screenutil.dart';
//import '.././models/user.dart';

class Data {
  String username;
  int id;

  Data({this.username, this.id});
}

final Data data = Data(username: '', id: 0);
bool loginfail = false;
bool loading = false;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class FirstTime extends StatefulWidget {
  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20),
      child: Container(
        alignment: Alignment.topLeft,
        //color: Colors.red,
        height: 30,
        child: Row(
          children: <Widget>[
            Text(
              'Your first time?',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewUser()));
              },
              child: Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                name_g,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                email_g,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), ModalRoute.withName('/'));
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _myUsername = new TextEditingController();
  TextEditingController _myPassword = new TextEditingController();

  //bool loginfail = false;

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return loading
        ? LoadingPage()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(),
                  flex: 5,
                ),
                Expanded(
                  flex: 15,
                  child: Container(
                    alignment: Alignment.center,
                    child:
                        Image(image: AssetImage("assets/primusnameicon.png")),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 40,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 275,
                          child: Card(
                            semanticContainer: true,
                            margin: EdgeInsets.only(right: 20, left: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 10,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 500,
                                margin: EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      height: 45,
                                      child: Text("Login",
                                          style: TextStyle(
                                              fontSize: 20,
                                              letterSpacing: .6,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      height: 80,
                                      padding: EdgeInsets.only(top: 10),
                                      child: TextField(
                                        controller: _myUsername,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Username',
                                        ),
                                        onSubmitted: (String value) {
                                          _myUsername.text = value;
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      padding: EdgeInsets.only(top: 10),
                                      child: TextField(
                                        obscureText: true,
                                        controller: _myPassword,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Password',
                                          errorText: loginfail
                                              ? 'Username or password is incorrect!'
                                              : null,
                                        ),
                                        onSubmitted: (String value) {
                                          _myPassword.text = value;
                                        },
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                flex: 75,
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Your first time?',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewUser()));
                                        },
                                        child: Text(
                                          'SIGN UP',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 25,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 40,
                                    child: RaisedButton(
                                      color: Colors.pink,
                                      splashColor: Colors.white,
                                      child: const Text(
                                        'SIGN IN',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () async {
                                        data.username = _myUsername.text;
                                        //print('works');
                                        setState(() {
                                          loading = true;
                                        });
                                        bool loginsuccess = await getid(_myUsername.text,
                                            _myPassword.text, context);
                                        loginfail = true;
                                        print("loginfail");
                                        setState(() {
                                          print(loginsuccess);
                                          if(loginsuccess==false){loading = false;}
                                          
                                        });

                                        //User user = await fetchPost(_myUsername.text);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
          );
  }

}

Future<bool> getid(String uname, String pcode, BuildContext context) async {
  //print('entered');
  var userdetails = [];
  var routes;
  var weight;



  final response1 =
      await http.get('http://localhost:3333/users/?username=${uname}');
  
  
  if (response1.statusCode == 200) {
    weight = await (json.decode(response1.body))['weight'];
    final responsepass = await http.get(
        'http://localhost:3333/users/auth/?username=${uname}&password=${pcode}');
    if (responsepass.statusCode == 200) {
      bool pass = (json.decode(responsepass.body))['result'];

      if (pass == true) {
        print('login succesful');
        loginfail = false;
        final response3 = await http.get(
      'http://localhost:3333/algo/popular_routes/?weight=' + weight.toString());
        //setState(() => loading = true);
        data.id = (json.decode(response1.body))['id'];
        print((json.decode(response1.body))['username']);
        print((json.decode(response1.body))['name']);
        print((json.decode(response1.body))['age']);
        print((json.decode(response1.body))['height']);
        print((json.decode(response1.body))['weight']);
        userdetails.add((json.decode(response1.body))['username']);
        userdetails.add((json.decode(response1.body))['name']);
        userdetails.add((json.decode(response1.body))['age']);
        userdetails.add((json.decode(response1.body))['height']);
        userdetails.add((json.decode(response1.body))['weight']);
        routes = (json.decode(response3.body));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      id: data.id, profDetails: userdetails, popRoutes: routes,
                    )));
      } else {
        loginfail = true;
                print("Username or Password is wrong");

        return false;
      }
    }
    else {
    loginfail = true;

    print('Username or Password is wrong');
    return false;
  }
    
  } else {
    loginfail = true;

    print('Username or Password is wrong');
    return false;
  }
  return true;
  
}