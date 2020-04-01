import 'package:flutter/material.dart';
import '.././util/screenutil.dart';
import '.././models/user.dart';

class FormCard extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();

  @override
  final myController = TextEditingController();
  String username;
  String password; 
  
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(550),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 3.0),
                blurRadius: 3.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -3.0),
                blurRadius: 4.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Login",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Username",
                style: TextStyle(
                    
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(45))),
            TextField(
              controller: myController,
              decoration: InputDecoration(
                  hintText: "username",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Password",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(45))),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Row(
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
            
          ],
        ),
      ),
    );
  }
}