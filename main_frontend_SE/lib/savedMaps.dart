import 'dart:async';
import 'package:bicycle/Routez.dart';
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
      home: SavedMap(),
    );
    //State<StatefulWidget> createState() => RecommenderState();
  }
}

class SavedMap extends StatefulWidget {
  State<StatefulWidget> createState() => SavedMapsCard();
}

class SavedMapsCard extends State<SavedMap> {
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Saved Maps',
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
              child: Card(
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Routez()),
                    );
                  },
                  child: Container(
                    width: 500,
                    height: 200,
                    child: Stack(
                      children: <Widget>[
                        // GoogleMap(
                        //     myLocationEnabled: true,
                        //     myLocationButtonEnabled: false,
                        //     compassEnabled: false,
                        //     tiltGesturesEnabled: false,
                        //     markers: _markers,
                        //     polylines: _polylines,
                        //     mapType: MapType.normal,
                        //     initialCameraPosition: CameraPosition(
                        //         zoom: CAMERA_ZOOM,
                        //         bearing: CAMERA_BEARING,
                        //         tilt: CAMERA_TILT,
                        //         target: SOURCE_LOCATION),
                        //     onMapCreated: onMapCreated),
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
                                scrollGesturesEnabled: false,
                                rotateGesturesEnabled: false,
                                compassEnabled: false,
                                tiltGesturesEnabled: false,
                                markers: _markers,
                                polylines: _polylines,
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                    zoom: CAMERA_ZOOM,
                                    bearing: CAMERA_BEARING,
                                    tilt: CAMERA_TILT,
                                    target: SOURCE_LOCATION),
                                onMapCreated: onMapCreated,
                                //options:
                              ),

                              //color: Colors.green,

                              //alignment: Alignment.topCenter,
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
                                        "30KM", // this is a random value. original value must be extracted from database / route detail and replaced here
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                              color: Colors.black38, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "120 Mins", // this is a random value. original value must be extracted from database / route detail and replaced here
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                              color: Colors.black38, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "300 KCal", // this is a random value. original value must be extracted from database / route detail and replaced here
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
