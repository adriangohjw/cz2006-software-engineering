import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Search.dart';
import 'profile.dart';
import 'Routez.dart';
import 'PopularMaps.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return  MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      );
    }
}

class MyHomePage extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
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
          TabBarView(children: [Search(), ProfilePage(), PopMap()],
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