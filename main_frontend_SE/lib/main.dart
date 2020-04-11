import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Search.dart';
import 'profile.dart';
import 'Routez.dart';
import 'PopularMaps.dart';
import 'package:bicycle/login_page.dart';


void main() => runApp(MyApp());
int userid = 1;//has to be extracted from previous file
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return  MaterialApp(
      title: 'Flutter Demo',
      home: LoginPage(),
      );
    }
}

class MyHomePage extends StatefulWidget {
  int id;
  MyHomePage({this.id});
  @override
  _MyHomePageState createState() => _MyHomePageState(userid: id);
}

class _MyHomePageState extends State<MyHomePage> {
  int userid;
  _MyHomePageState ({@required this.userid});
  var userdetails;
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: 3,
        child: new Scaffold(
          body: 
         /*
          RaisedButton(
            child: Text('Go'),
            onPressed: (){
              Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
              Search()),
        );
            },)
          */
          TabBarView(children: [Search(id: userid), ProfilePage(id: userid, PersDet: userdetails,), PopMap()],
          physics: NeverScrollableScrollPhysics(),),
        
        bottomNavigationBar: new TabBar(tabs: <Widget>[
          Tab(icon: Icon(Icons.directions_bike)),
          Tab(icon: Icon(Icons.person_outline)),
          Tab(icon: Icon(Icons.star))
        ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.blue,
            
          ),
          backgroundColor: Colors.white,  
          // */
    ),
    ),
    );
  }
}