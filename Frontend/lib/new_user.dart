import 'package:flutter/material.dart';
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

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
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
                    SingUp(),
                    TextNew(),
                  ],
                ),
                NewNome(),
                NewEmail(),
                PasswordInput(),
                NewAge(),
                NewHeight(),
                NewWeight(),
                ButtonNewUser(),
                UserOld(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}