import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'new_user.dart';
import 'Widgets/FormCard.dart';
import 'util/screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

//import '.././util/screenutil.dart';
//import '.././models/user.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

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
                name,
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
                email,
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
  bool _isSelected = false;
  TextEditingController _myController = new TextEditingController();
  TextEditingController _myPassController = new TextEditingController();
  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

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
    final _formKey = GlobalKey<FormState>();
    //Model model = Model();

    @override
    
    String username;
    String password;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: Image(
                image: AssetImage("assets/primusnameicon.png"), height: 150.0),
          ),
          //FirstTime(),
          // InkWell(
          //   child: Container(
          //     width: ScreenUtil.getInstance().setWidth(200),
          //     height: ScreenUtil.getInstance().setHeight(50),
          //     decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //             colors: [Color(0xFFFFFFFF), Color(0XFFFFFFFF)]),
          //         borderRadius: BorderRadius.circular(1.0),
          //         boxShadow: [
          //           BoxShadow(
          //               color: Color(0x0000000).withOpacity(.1),
          //               offset: Offset(0.0, 0.0),
          //               blurRadius: 1.0)
          //         ]),
          //     child: Material(
          //       color: Colors.transparent,
          //       child: InkWell(
          //         onTap: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) {
          //                 return RegisterForm();
          //               },
          //             ),
          //           );
          //         },
          //         child: Center(
          //           child: Text("REGISTER",
          //               style: TextStyle(
          //                   color: Colors.black,
          //                   fontFamily: "Poppins-Bold",
          //                   fontSize: 10,
          //                   letterSpacing: 1.0)),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Card(
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
                height: 240,
                margin: EdgeInsets.all(20),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
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
                        controller: _myController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                        onSubmitted: (String value) {
                          _myController.text = value;
                        },
                      ),
                    ),
                    Container(
                      height: 80,
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        obscureText: true,
                        controller: _myPassController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        onSubmitted: (String value) {
                          _myPassController.text = value;
                        },
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(25)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),
            alignment: Alignment.topLeft,
            //color: Colors.red,
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 75,
                  child: Container(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewUser()));
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
                ),
                Expanded(
                  flex: 25,
                  child: Container(
                    child: RaisedButton(
                      color: Colors.black,
                      splashColor: Colors.white,
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _handleSignIn,
                    ),
                  ),
                )
              ],
            ),
          ),

          Container(
            height: 50,
            margin: EdgeInsets.only(top: 30),
            child: _signInButton(),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FirstScreen();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
