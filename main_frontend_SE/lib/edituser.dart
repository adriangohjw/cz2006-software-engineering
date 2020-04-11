import 'package:flutter/material.dart';
import 'profile.dart';
import 'Widgets/buttonNewUser.dart';
import 'Widgets/newEmail.dart';
import 'Widgets/newName.dart';
import 'Widgets/password.dart';
import 'Widgets/singup.dart';
import 'Widgets/textNew.dart';
import 'Widgets/userOld.dart';
import 'Widgets/newAge.dart';
import 'Widgets/newHeight.dart';
import 'Widgets/newWeight.dart';

class EditUser extends StatefulWidget {
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
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
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ],
                ),
                NewNome(),
                NewEmail(),
                NewAge(),
                NewHeight(),
                NewWeight(),
                SizedBox(height: 30),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      Navigator.pop(context);
                    }), ModalRoute.withName('/'));
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
