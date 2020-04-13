import 'dart:async';
import 'dart:convert';
import 'package:bicycle/Routez.dart';
import 'package:bicycle/new_user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'loadingPage.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PopMap(id: 1),
//     );
//     //State<StatefulWidget> createState() => RecommenderState();
//   }
// }

class PopMap extends StatefulWidget {
  int id;
  var poproutes;
  PopMap({@required this.id, @required this.poproutes});
  State<StatefulWidget> createState() => PopMapPage(userid: id, searchOutput:poproutes);
}

class PopMapPage extends State<PopMap> {
  int userid; 
  var searchOutput;
  PopMapPage({@required this.userid, @required this.searchOutput});  
  
  GoogleMapController mapController;
  var searchAttr=[];
  List<Set> poly = [];
  List<Set> mark = [];
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  String googleAPIKey = "AIzaSyA3YCs9pJnxE9gXAAkGDO3vNxxOsVgjWw8";
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;
  
  TextEditingController _textcontrollerdist = new TextEditingController();
  TextEditingController _textcontrollercalo = new TextEditingController();
  //bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? LoadingPage : Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Popular Maps',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    for (var i = 0; i < searchOutput[0].length; i++) _mapfunc(context, i),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    //controller.setMapStyle(Utils.mapStyles);
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Widget _mapfunc(BuildContext context, int index) {
    final polyline = searchOutput[9];
    final routeAsc = searchOutput[1];
    final routeDesc = searchOutput[2];
    final routeFlat = searchOutput[3];
    final routeDist = searchOutput[4];
    final routeTime = searchOutput[7];
    final routeCal = searchOutput[8];
    final routeElevDetails = searchOutput[10];
    final routeFitness = searchOutput[6];
    //var locs = getmarkerPoints(searchOutput);
    final startLocs = LatLng(searchOutput[0][index]['legs'][0]["start_location"]['lat'],
            searchOutput[0][index]['legs'][0]["start_location"]['lng']);
    final endLocs = LatLng(searchOutput[0][index]['legs'][0]["end_location"]['lat'],
            searchOutput[0][index]['legs'][0]["end_location"]['lng']);
    setMapPins(startLocs, endLocs);
    setPolylines(polyline[index], [], PolylinePoints());

    return Card(
      semanticContainer: true,
      margin: EdgeInsets.only(bottom: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          setState(() => loading = true);
          var routeDet = [];
          routeDet.add(searchOutput[0][index]);
          routeDet.add(routeDist[index].toStringAsFixed(1));
          routeDet.add(routeTime[index].round().toString());
          routeDet.add(routeCal[index].round().toString());
          routeDet.add(routeAsc[index].toStringAsFixed(1));
          routeDet.add(routeDesc[index].toStringAsFixed(1));
          routeDet.add(routeFlat[index].toStringAsFixed(1));
          routeDet.add(polyline[index]);
          routeDet.add(routeElevDetails[index]);
          routeDet.add(searchOutput[6][index]);
          setState(() => loading = false);
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Routez(id: userid, route: routeDet)),
          );
        },
        child: Container(
          width: 500,
          height: 300,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 500,
                    height: 150,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.blue,
                    ),

                    child: GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      scrollGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      compassEnabled: false,
                      tiltGesturesEnabled: true,

                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          zoom: CAMERA_ZOOM,
                          bearing: CAMERA_BEARING,
                          tilt: CAMERA_TILT,
                          target: LatLng(
                              searchOutput[0][index]['legs'][0]["end_location"]
                                  ['lat'],
                              searchOutput[0][index]['legs'][0]["end_location"]
                                  ['lng'])),
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                          //setMapPins(startLocs[index], endLocs[index]);
                          //setPolylines(polyline[index], [],PolylinePoints());
                        });
                      },
                      markers: _markers,
                      polylines: poly[index],

                      // (GoogleMapController controller) {
                      //   _controller.complete(controller);
                      //   setMapPins(startLocs[index], endLocs[index]);
                      //   setPolylines(polyline[index], [],PolylinePoints());
                      // },

                      //options:
                    ),

                    //color: Colors.green,

                    //alignment: Alignment.topCenter,
                  ),
                  Container(
                    width: 500,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black38, width: 1),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              routeDist[index].toStringAsFixed(1) +
                                  ' Km', // this is a random value. original value must be extracted from database / route detail and replaced here
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                right:
                                    BorderSide(color: Colors.black38, width: 1),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              routeTime[index].round().toString() +
                                  ' Mins', // this is a random value. original value must be extracted from database / route detail and replaced here
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                right:
                                    BorderSide(color: Colors.black38, width: 1),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              routeCal[index].round().toString() +
                                  ' KCal', // this is a random value. original value must be extracted from database / route detail and replaced here
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 50,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black38,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Ascent: ' +
                                  routeAsc[index].toStringAsFixed(1) +
                                  ' Km', // this is a random value. original value must be extracted from database / route detail and replaced here
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                right:
                                    BorderSide(color: Colors.black38, width: 1),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Descent: ' +
                                  routeDesc[index].toStringAsFixed(1) +
                                  ' Km', // this is a random value. original value must be extracted from database / route detail and replaced here
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 50,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Flat: ' +
                                  routeFlat[index].toStringAsFixed(1) +
                                  ' Km', // this is a random value. original value must be extracted from database / route detail and replaced here
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                right:
                                    BorderSide(color: Colors.black38, width: 1),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  flex: 70,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Fitness Level: ", // this is a random value. original value must be extracted from database / route detail and replaced here
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 30,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        routeFitness[index]
                                            .toStringAsFixed(1)
                                            .substring(0, 1),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setMapPins(LatLng source, LatLng dest) {
    setState(() {
      _markers = {};
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'), position: source, icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: dest,
          icon: destinationIcon));

      mark.add(_markers);
    });
  }
    
  setPolylines(String pol, List<LatLng> polylineCoordinates,
      PolylinePoints polylinePoints) async {
    // List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
    //     googleAPIKey,
    //     SOURCE_LOCATION.latitude,
    //     SOURCE_LOCATION.longitude,
    //     DEST_LOCATION.latitude,
    //     DEST_LOCATION.longitude);

    List<PointLatLng> result = polylinePoints.decodePolyline(pol);
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
      _polylines = {};
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
      poly.add(_polylines);
    });
  }
  
  
}
