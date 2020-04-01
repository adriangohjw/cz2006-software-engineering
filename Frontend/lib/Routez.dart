import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'liveNav.dart';

class Routez extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}


const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(1.355435, 103.685172);
const LatLng DEST_LOCATION = LatLng(1.341454, 103.684035);


class _MapPageState extends State<Routez> {
    Completer<GoogleMapController> _controller = Completer();
    Set<Marker> _markers = {};
    Set<Polyline> _polylines = {};
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    String googleAPIKey = "AIzaSyA3YCs9pJnxE9gXAAkGDO3vNxxOsVgjWw8";
    BitmapDescriptor sourceIcon;
    BitmapDescriptor destinationIcon;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
        children: <Widget>[GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
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

            onMapCreated: onMapCreated),

          Column(children: <Widget> [
            Spacer(flex: 2,),
            Container(child: Row(children: <Widget>[Spacer(),
                FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.arrow_back),
                  backgroundColor: Colors.white,
                  onPressed:(){
                    Navigator.pop(context);
                  }
                    
                  ,
                  foregroundColor: Colors.black,
                ),
                Spacer(flex:9),
              ],
            ),
          ),
            Spacer(flex: 17,),
            Container(child: Row(
              children: <Widget>[
                Spacer(flex:9),
                FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.my_location),
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ), 
                Spacer(),
              ],
            ),
          ),
          Spacer(),
          Container(child: Row(
              children: <Widget>[
                Spacer(),
                FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.favorite_border),
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  foregroundColor: Colors.red,
                ),
                Spacer(flex:8),
                Container(
                child: CupertinoButton(
                  child: Text("START"),
                  color: Colors.black,
                  onPressed:(){Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
              LiveNav()),
        );}
                    //_onButtonPressedf
                  ,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                ),
                Spacer(),
              ],
            ),),
          Spacer(),
        ],
      ),

      ],
        ),
      );
    }

    // @override
    // void initState() {
    //   super.initState();
    //   setSourceAndDestinationIcons();
    // }

    void setSourceAndDestinationIcons() async {
      sourceIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');
      destinationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'assets/destination_map_marker.png');
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
/*
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
*/