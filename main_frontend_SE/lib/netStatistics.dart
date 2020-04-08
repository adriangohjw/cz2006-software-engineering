import 'dart:async';
import 'package:bicycle/Routez.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() {
  runApp(MyApp());
}

const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(1.355435, 103.685172);
const LatLng DEST_LOCATION = LatLng(1.341454, 103.684035);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NetStats(),
    );
    //State<StatefulWidget> createState() => RecommenderState();
  }
}

class NetStats extends StatefulWidget {
  State<StatefulWidget> createState() => StatsState();
}

class DailyDist {
  final String date;
  final int dist;

  DailyDist({@required this.date, @required this.dist});
}

class DailyCal {
  final String date;
  final int cal;

  DailyCal({@required this.date, @required this.cal});
}

class StatsState extends State<NetStats> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyA3YCs9pJnxE9gXAAkGDO3vNxxOsVgjWw8";
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<DailyDist> distData = [
    DailyDist(date: "25 Mar", dist: 100),
    DailyDist(date: "26 Mar", dist: 300),
    DailyDist(date: "27 Mar", dist: 400),
    DailyDist(date: "28 Mar", dist: 200),
    DailyDist(date: "29 Mar", dist: 600),
    DailyDist(date: "30 Mar", dist: 150),
    DailyDist(date: "31 Mar", dist: 550),
  ];

  final List<DailyCal> calData = [
    DailyCal(date: "25 Mar", cal: 100),
    DailyCal(date: "26 Mar", cal: 300),
    DailyCal(date: "27 Mar", cal: 400),
    DailyCal(date: "28 Mar", cal: 200),
    DailyCal(date: "29 Mar", cal: 600),
    DailyCal(date: "30 Mar", cal: 150),
    DailyCal(date: "31 Mar", cal: 550),
  ];
  

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailyDist, String>> seriesdist = [
      charts.Series(
          id: "Daily Distance this week",
          data: distData,
          domainFn: (DailyDist seriesdist, _) => seriesdist.date,
          measureFn: (DailyDist seriesdist, _) => seriesdist.dist,
          colorFn: (DailyDist seriesdist, _) =>
              charts.ColorUtil.fromDartColor(Colors.red))
    ];

    List<charts.Series<DailyCal, String>> seriescal = [
      charts.Series(
          id: "Daily Calories this week",
          data: calData,
          domainFn: (DailyCal seriescal, _) => seriescal.date,
          measureFn: (DailyCal seriescal, _) => seriescal.cal,
          colorFn: (DailyCal series, _) =>
              charts.ColorUtil.fromDartColor(Colors.red))
    ];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Net Statistics',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          splashColor: Colors.black.withAlpha(30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 500,
                        height: 200,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: charts.BarChart(seriesdist, animate: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: 40, left: 10, right: 10),
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 500,
                        height: 200,
                        child: Column(
                          children: <Widget>[Expanded(
                              child: charts.BarChart(seriescal, animate: true),
                            ),],
                        ),
                      ),
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

  void onMapCreated(GoogleMapController controller) {
    //controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: destinationIcon));
    });
  }

  setPolylines() async {
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude,
        DEST_LOCATION.latitude,
        DEST_LOCATION.longitude);
    print(result);
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }
}
