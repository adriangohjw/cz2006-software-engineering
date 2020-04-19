import 'dart:async';
import 'package:bicycle/profile.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';

const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(1.355435, 103.685172);
const LatLng DEST_LOCATION = LatLng(1.341454, 103.684035);

class NetStats extends StatefulWidget {
  var Dist;
  var Cal;
  NetStats({@required this.Dist, @required this.Cal});
  State<StatefulWidget> createState() =>
      StatsState(distData: Dist, calData: Cal);
}

// class DailyDist {
//   final String date;
//   final int dist;

//   DailyDist({@required this.date, @required this.dist});
// }

// class DailyCal {
//   final String date;
//   final int cal;

//   DailyCal({@required this.date, @required this.cal});
// }

class StatsState extends State<NetStats> {
  var distData;
  var calData;
  //var list;
  StatsState({@required this.distData, @required this.calData});
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyA3YCs9pJnxE9gXAAkGDO3vNxxOsVgjWw8";
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    
    //print()
    // print('now');
    // print(distData);
    return (distData.isEmpty)
        ? Scaffold(
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Spacer(flex: 1),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(right: 30, left: 30),
                          alignment: Alignment.center,
                          child: Text(
                              "You haven't completed any routes yet. Time to complete some routes now!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lora(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic)),
                        ),
                      ),
                      Spacer(flex: 1),
                    ],
                  ))
        : Scaffold(
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
                                      child: Text(
                                        'Daily Distance travelled',
                                        style: GoogleFonts.lora(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      flex: 2),
                                  Expanded(
                                    flex: 9,
                                    child: charts.BarChart(seriesdist,
                                        animate: true),
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
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                        'Daily Calories burnt',
                                        style: GoogleFonts.lora(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      flex: 2),
                                  Expanded(
                                    flex: 9,
                                    child: charts.BarChart(seriescal,
                                        animate: true),
                                  ),
                                ],
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
}
