import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 60;
const double CAMERA_BEARING = 30;

class LiveNav extends StatefulWidget {
  int id;
  var route;
  LiveNav({@required this.id, @required this.route});
  @override
  State<StatefulWidget> createState() => MapPageState(UserID:id, routeDet: route);
}

class MapPageState extends State<LiveNav> {
  int UserID;
  var routeDet;
  MapPageState({@required this.UserID, @required this.routeDet});
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = "AIzaSyA3YCs9pJnxE9gXAAkGDO3vNxxOsVgjWw8";
// for my custom marker pins
  BitmapDescriptor currentlocationIcon,sourceIcon;
  BitmapDescriptor destinationIcon;
// the user's initial location and current location
// as it moves
  LocationData currentLocation;
// a reference to the destination location
  LocationData destinationLocation;
// wrapper around the location API
  Location location;
  double speed=0.0;
  String displayspeed="0.0";
  double timeinhrs=0.0;
  int ispressed=0,weight=100;
  double distance=0;
  String displaydistance='0.0';
  BitmapDescriptor currentlocationicon ;
  var swatch=new Stopwatch();
  var speedList=new List();
  double met;
  double cal=0.0;
  final dur=const Duration(seconds:1);
  var stoptimetodisplay;
  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();

    polylinePoints = PolylinePoints();

    showPinsOnMap();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      updatePinOnMap();
    });
     
    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
   
    setInitialLocation();
    if(ispressed==0){
      _location();
      timePassed();
      
    }
  }

  void setSourceAndDestinationIcons() async {
    currentlocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/biking.png');
  }

  void setInitialLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();

    // hard-coded destination for this example
    destinationLocation = LocationData.fromMap({
      "latitude": LatLng(routeDet[0]['legs'][0]["end_location"]['lat'], routeDet[0]['legs'][0]["end_location"]['lng']).latitude,
      "longitude": LatLng(routeDet[0]['legs'][0]["end_location"]['lat'], routeDet[0]['legs'][0]["end_location"]['lng']).longitude
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(routeDet[0]['legs'][0]["start_location"]['lat'], routeDet[0]['legs'][0]["start_location"]['lng']));
    if (currentLocation != null) { 
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: 50,
        maxHeight: 200,
        panel: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.black38, width: 1),
                          bottom: BorderSide(color: Colors.black38, width: 1),
                        ),
                      ),
                      child: Text(
                        "$displaydistance", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.black38, width: 1),
                          bottom: BorderSide(color: Colors.black38, width: 1),
                        ),
                      ),
                      child: Text(
                        "10KM", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.black38, width: 1),
                          bottom: BorderSide(color: Colors.black38, width: 1),
                        ),
                      ),
                      child: Text(
                        "$stoptimetodisplay", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black38, width: 1),
                        ),
                      ),
                      child: Text(
                        "$cal", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                        "Speed ", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ), 
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "$displayspeed", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black38,
                    width: 1,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                        "Ascent ", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "2 m", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Colors.black38,
                  width: 1,
                ),
              )),
            ),
            Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                        "Descent ", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "3 m", // this is a random value. original value must be extracted from database / route detail and replaced here
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Colors.black38,
                  width: 1,
                ),
              )),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
                //myLocationEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                tiltGesturesEnabled: false,
                markers: _markers,
                polylines: _polylines,
                buildingsEnabled: false,
                mapType: MapType.normal,
                padding: EdgeInsets.only(top: 40.0),
                initialCameraPosition: initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle(Utils.mapStyles);
                  _controller.complete(controller);
                  // my map has completed being created;
                  // i'm ready to show the pins on the map
                  showPinsOnMap();
                  setPolylines();
                }),
            Column(
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Row(
                  children: <Widget>[
                    Spacer(),
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.arrow_back),
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      foregroundColor: Colors.black,
                    ),
                    Spacer(flex: 9),
                  ],
                ),
                Spacer(
                  flex: 16,
                ),
                Row(
                  children: <Widget>[
                    Spacer(flex: 9),
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.my_location),
                      onPressed: () {_currentLocation();
                      updatePinOnMap();},
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
                Row(
                  children: <Widget>[
                    Spacer(flex: 9),
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.pause),
                      onPressed: () {if(ispressed==0){
                                        stoptime();
                                       ispressed=1;}
                        else{
                          ispressed=0;
                          timePassed();
                        }
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
                Row(
                  children: <Widget>[
                    Spacer(flex: 9),
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.stop),
                      onPressed:(){ _showTravelSummary();
                      ispressed=1;},
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
                Container(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _showTravelSummary(){
    
    showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Toute is complete!'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              Row(
              children: <Widget>[
                new Text('Distance covered: '),
                new Text('$distance')
                ],
              ),
              Row(
              children: <Widget>[
                new Text('Total Time Travelled: '),
                new Text('$timeinhrs')
                ],
              ),
              Row(
              children: <Widget>[
                new Text('Total Calories Burnt: '),
                new Text('$cal')
                ],
              ),
              Row(
              children: <Widget>[
                new Text('Total Ascent: '),
                new Text('15 Km')
                ],
              ),
              Row(
              children: <Widget>[
                new Text('Total Descent: '),
                new Text('10 Km')
                ],
              ),
              Row(
              children: <Widget>[
                new Text('Total Flat Pathway: '),
                new Text('5 Km')
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Complete Journey'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

  }
  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(routeDet[0]['legs'][0]["start_location"]['lat'], routeDet[0]['legs'][0]["start_location"]['lng']);
    // get a LatLng out of the LocationData object
    var destPosition = LatLng(routeDet[0]['legs'][0]["end_location"]['lat'], routeDet[0]['legs'][0]["end_location"]['lng']);

    // add the initial source location pin
   

    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: sourceIcon));

    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
  }

setPolylines() async {

        // List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        //     googleAPIKey,
        //     SOURCE_LOCATION.latitude,
        //     SOURCE_LOCATION.longitude,
        //     DEST_LOCATION.latitude,
        //     DEST_LOCATION.longitude);
        List<PointLatLng> result = polylinePoints.decodePolyline(routeDet[7]);
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

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: 18,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
     // _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('curpin'),
          position: pinPosition, // updated position
          icon: currentlocationIcon));
    });
  }
void _currentLocation() async {
   final GoogleMapController controller = await _controller.future;
   LocationData currentLocation;
   var location = new Location();
   try {
     currentLocation = await location.getLocation();
     } on Exception {
       currentLocation = null;
       }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }
  Future _location() async{
   Location location = Location();
    location.onLocationChanged.listen((LocationData value) {
      setState(() {
        currentLocation = value;
        speed=(currentLocation.speed*(5/18))  ;
        displayspeed=speed.toStringAsFixed(2).toString();
        distance+=(speed*timeinhrs);
        displaydistance=distance.toStringAsFixed(2);


        speedList.add(speed);
        calorieCalculator(speed);


      });
    });
  }
  void timePassed(){
   swatch.start();
   starttimer(); 
    }
  void starttimer(){
    Timer(dur,keeprunning);
  }
  void keeprunning(){
    if(swatch.isRunning){
      starttimer();
    }
    setState(() {
    stoptimetodisplay=swatch.elapsed.inMinutes.toString().padLeft(2,"0")+":"+(swatch.elapsed.inSeconds%60).toString().padLeft(2,"0");
    timeinhrs=(swatch.elapsed.inSeconds)/3600;
    });
  }
  void stoptime(){
    swatch.stop();
  }
 void calorieCalculator(cSpeed) {
    if(double.parse(cSpeed)!=0){
      if(double.parse(cSpeed)<8){
        met=4.9;
      }
      else if(double.parse(cSpeed)>8&&(double.parse(cSpeed)<11)){
        met=6.8;
      }
      else if(double.parse(cSpeed)>11&&(double.parse(cSpeed)<13)){
        met=8;
      }
       else if(double.parse(cSpeed)>13&&(double.parse(cSpeed)<16)){
        met=11;
      }
       else if(int.parse(cSpeed)>16){
        met=15.8;
      }
    double distmile=distance*0.621371;
    double calpm=(met*weight*3.5)/200;
    double time=(distmile/double.parse(cSpeed))*60; 
    setState(() { 
      cal=cal+(calpm*time);
      cal=num.parse(cal.toStringAsFixed(2));
  });
  }
      
}
}



class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}

