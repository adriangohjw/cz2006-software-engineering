import 'dart:async';
import 'dart:convert';
import 'package:bicycle/Routez.dart';
import 'package:bicycle/new_user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'loadingPage.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(MyApp());
// }

const double CAMERA_ZOOM = 14;
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

class SavedMap extends StatefulWidget {
  int id;
  var pastroutes;
  SavedMap({@required this.id, @required this.pastroutes});
  State<StatefulWidget> createState() =>
      SavedMapsCard(userid: id, searchOutput: pastroutes);
}

class SavedMapsCard extends State<SavedMap> {
  int userid;
  var searchOutput;
  SavedMapsCard({@required this.userid, @required this.searchOutput});

  GoogleMapController mapController;
  var searchAttr = [];
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
    return loading
        ? LoadingPage
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Past Rides',
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
            body: (searchOutput.length == 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Spacer(flex: 1),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(right: 30, left: 30),
                          alignment: Alignment.center,
                          child: Text(
                              "You haven't completed any rides. Time to complete a ride now!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lora(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic)),
                        ),
                      ),
                      Spacer(flex: 1),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                for (var i = 0; i < searchOutput.length; i++)
                                  _mapfunc(context, i),
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
    final polyline = getAttr(searchOutput, "polyline");
    final routeAsc = getAttr(searchOutput, "ascent");
    final routeDesc = getAttr(searchOutput, "descent");
    final routeFit = getAttr(searchOutput, "purpose");
    final routeDist = getAttr(searchOutput, "distance");
    final routeTime = getAttr(searchOutput, "created_at");
    final routeCal = getAttr(searchOutput, "calories");

    //final routeElevDetails = getAttr(searchOutput, "polyline");
    //var locs = getmarkerPoints(searchOutput);
    print("yeee");
    final startLocs = LatLng(searchOutput[index]["startPos"]['latitude'],
        searchOutput[index]["startPos"]['longtitude']);
    final endLocs = LatLng(searchOutput[index]["endPos"]['latitude'],
        searchOutput[index]["endPos"]['longtitude']);
    print(startLocs);
    print(endLocs);
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
        onTap: () {},
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
                              searchOutput[index]["endPos"]['latitude'],
                              searchOutput[index]["endPos"]['longtitude'])),
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
                              'Distance: ' +
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
                              'Calories: ' +
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
                              routeTime[index].substring(0,
                                  16), // this is a random value. original value must be extracted from database / route detail and replaced here
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
                                        routeFit[index],
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

  List getAttr(routes, String attr) {
    print("HELLLLLLLLLLLLOOOOOO");
    var lst = [];
    int l = (routes.length) - 1;
    for (int i = 0; i <= l; i++) {
      lst.add(routes[i][attr]);
    }
    print(lst);
    return lst;
  }
}
