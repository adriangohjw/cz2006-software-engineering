import 'package:flutter/material.dart';

class TextNew extends StatefulWidget {
  @override
  _TextNewState createState() => _TextNewState();
}

class _TextNewState extends State<TextNew> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0),
      child: Container(
        height: 200,
        width: 300,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
            ),
            Center(
              child: Text(
                'Welcome to Primus!',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}