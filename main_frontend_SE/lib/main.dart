import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Search.dart';
import 'profile.dart';
import 'Routez.dart';
import 'PopularMaps.dart';
import 'package:bicycle/login_page.dart';


void main() => runApp(MyApp());
int userid;//has to be extracted from previous file
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return  MaterialApp(
      title: 'Flutter Demo',
      home: LoginPage()
      //MyHomePage(id: 1, profDetails: ["adrian", "adrian", 20, 190, 60],),
      );
    }
}

class MyHomePage extends StatefulWidget {
  int id;
  var profDetails;
  var popRoutes;
  MyHomePage({this.id, this.profDetails
    ,this.popRoutes
   });
  @override
  _MyHomePageState createState() => _MyHomePageState(userid: id, userDetails: profDetails , popularRoutes: popRoutes
  );
}

class _MyHomePageState extends State<MyHomePage> {
  int userid;
  var userDetails;
  var popularRoutes;
  //var searchResults;
  _MyHomePageState ({@required this.userid, @required this.userDetails, @required this.popularRoutes
  });
  get http => null;
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
          TabBarView(children: [Search(id: userid), ProfilePage(id: userid, PersDet: userDetails,popRoutes: popularRoutes,), PopMap(id:1, poproutes: popularRoutes,)],
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
            onTap: (index) async {
              
            },
            
          ),
          backgroundColor: Colors.white,  
          // */
    ),
    ),
    );
  }
  Future getUserDetails()async{
  var userdetails;
  var response1 = await http.get('http://localhost:3333/users/id/?id='+userid.toString());
  if (response1.statusCode==200)
  {
    
  userdetails.add((json.decode(response1.body))['username']);
  userdetails.add((json.decode(response1.body))['name']);
  userdetails.add((json.decode(response1.body))['age']);
  userdetails.add((json.decode(response1.body))['height']);
  userdetails.add((json.decode(response1.body))['weight']);
  
  } else{
    throw Exception('Failed to load details');
  }
  return userdetails;
  }
}