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
//const LatLng SOURCE_LOCATION = LatLng(1.355435, 103.685172);
//const LatLng DEST_LOCATION = LatLng(1.341454, 103.684035);
//enum ElevationLevel { Uphill, Downhill, Balanced, Flat }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
    //State<StatefulWidget> createState() => RecommenderState();
  }
}

class MyHomePage extends StatefulWidget {
  State<StatefulWidget> createState() => RecommenderState();
}

class RecommenderState extends State<MyHomePage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyA3YCs9pJnxE9gXAAkGDO3vNxxOsVgjWw8";
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _fitnessSliderInitVal = 5;
  double maxDist;
  double minCal;
  TextEditingController _textcontrollerdist = new TextEditingController();
  TextEditingController _textcontrollercalo = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routeDist = ['20KM', '30KM', '40KM', '50KM'];
    

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Recommended Routes',
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            splashColor: Colors.black.withAlpha(30),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 40,
              alignment: Alignment.center,
              child: Text(
                "Filter",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                //obscureText: true,
                controller:
                    _textcontrollerdist, // This value should be taken from the database, and used as initial value
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Max Distance (Kms)',
                ),
                onSubmitted: (String value) {
                  maxDist = double.parse(value);
                  _textcontrollerdist.text = value;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                //obscureText: true,
                controller:
                    _textcontrollercalo, // This value should be taken from the database, and used as initial value
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Total Calories to burn (KCal))',
                ),
                onSubmitted: (String value) {
                  minCal = double.parse(value);
                  _textcontrollercalo.text =
                      value; // Should update to database only if the tick button is clicked.
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 150,
                    child: Icon(
                      Icons.airline_seat_recline_extra,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 700,
                    child: Container(
                      height: 40,
                      child: SliderTheme(
                        child: Slider(
                          value: _fitnessSliderInitVal
                              .toDouble(), // This value should be taken from the database, and used as initial value
                          min: 1,
                          max: 5,
                          divisions: 4,
                          onChanged: (double newValue) {
                            setState(() {
                              _fitnessSliderInitVal = newValue
                                  .round(); // Should update to database only if the tick button is clicked.
                            });
                          },
                          onChangeEnd: (double newValue) {
                            print('Ended change on $newValue');
                          },
                          onChangeStart: (double startValue) {
                            print('Started change at $startValue');
                          },
                        ),
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 30,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 0),
                          thumbColor: Colors.black,
                          activeTrackColor: Colors.black,
                          inactiveTrackColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 150,
                    child: Icon(
                      Icons.fitness_center,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.done,
                        size: 50,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.cached,
                        size: 50,
                      ),
                      onPressed: () {
                        _textcontrollercalo.value = TextEditingValue.empty;
                        _textcontrollerdist.value = TextEditingValue.empty;

                        setState(() {
                          _fitnessSliderInitVal = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                    for (var i = 0; i < routeDist.length; i++)
                      _mapfunc(context, i)
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

  Widget _mapfunc(BuildContext context, int index) {
    final routeDist = ['20KM', '30KM', '40KM', '50KM'];
    final routeTime = ['200 Mins', '250 Mins', '300 Mins', '350 Mins'];
    final routeCal = ['1000KCal', '2000KCal', '3000KCal', '4000KCal'];
    final routeAsc = ['10Km', '20Km', '30Km', '40Km'];
    final routeDesc = ['1Km', '2Km', '3Km', '4Km'];
    final routeFlat = ['100Km', '200Km', '300Km', '400Km'];
    final startLocs = [
      LatLng(1.355435, 103.685172),
      LatLng(1.344454, 103.686035),
      LatLng(1.347454, 103.687035),
      LatLng(1.350454, 103.688035)
    ];
    final endLocs = [
      LatLng(1.341454, 103.684035),
      LatLng(1.350454, 103.688035),
      LatLng(1.344454, 103.686035),
      LatLng(1.347454, 103.687035)
    ];

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
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Routez()),
          );
        },
        child: Container(
          width: 500,
          height: 250,
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
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        setMapPins(startLocs[index], endLocs[index]);
                        setPolylines(startLocs[index], endLocs[index]);
                      },

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
                              routeDist[
                                  index], // this is a random value. original value must be extracted from database / route detail and replaced here
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
                              routeTime[
                                  index], // this is a random value. original value must be extracted from database / route detail and replaced here
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
                              routeCal[
                                  index], // this is a random value. original value must be extracted from database / route detail and replaced here
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
                              routeAsc[
                                  index], // this is a random value. original value must be extracted from database / route detail and replaced here
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
                              routeDesc[
                                  index], // this is a random value. original value must be extracted from database / route detail and replaced here
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
                              routeFlat[
                                  index], // this is a random value. original value must be extracted from database / route detail and replaced here
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
    );
  }

  void setMapPins(LatLng source, LatLng dest) {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'), position: source, icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: dest,
          icon: destinationIcon));
    });
  }

  setPolylines(LatLng source, LatLng dest) async {
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        source.latitude,
        source.longitude,
        dest.latitude,
        dest.longitude);
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
