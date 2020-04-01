import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:search_map_place/search_map_place.dart';
import 'Routez.dart';
import 'package:google_maps_webservice/places.dart';

import 'SearchResults.dart';

class Search extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyA3YCs9pJnxE9gXAAkGDO3vNxxOsVgjWw8");

class _MyAppState extends State<Search> {
  GoogleMapController mapController;
  String googleAPIKey = "AIzaSyA3YCs9pJnxE9gXAAkGDO3vNxxOsVgjWw8";
  //int _count = 0;
  final LatLng _center = const LatLng(1.3483, 103.6831);
  double _value = 3.0;
  void _setvalue(double value) => setState(() => _value = value);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
        ),

        Column(
          children: <Widget> [
        Spacer(flex: 2,),
        Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: 
                  
                  TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    
                    onTap: ()async{
                      Prediction p = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleAPIKey,
                          language: "en",
                          components: [Component(Component.country, "sg")],
                          mode: Mode.overlay);
                      var loc = displayPrediction(p);
                      print(loc);
                    },
                    
                    decoration: InputDecoration(
                      labelText: "Start Location...",
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20),
                        ),
                  ),
                ),
              ],
            ),
          ),
      Spacer(),
      Container(
            color: Colors.white,
            child: Row(
              children: 
              <Widget>[
                Expanded(
                  child: 
                  
                  TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    onTap: ()async{
                      Prediction p = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleAPIKey,
                          language: "en",
                          components: [Component(Component.country, "sg")],
                          mode: Mode.overlay);
                      displayPrediction(p);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20),
                        labelText: "End Location (optional)..."),
                  ),
                ),
              ],
            ),
          ),
      Spacer(),
      Container(
            color: Colors.white,
        child: Row(children: <Widget> [new Text("  Liesure "),new CupertinoSlider(value: _value, onChanged: _setvalue, divisions: 5, min: 1.0, max: 5.0),new Text("  Fitness ")],),),
      Spacer(), 
      
      Container(
            //color: Colors.white,
        child: CupertinoButton.filled(
      child: Text('Find Routes'),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
              MyHomePage()),
        );
      }
    ),
        ),
        Spacer(flex: 8,)
          ]
        )
      ],
    ),
      );
    
  }
  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      return(p.description);
    }
  }

}

