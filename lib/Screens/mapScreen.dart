import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/widgets.dart';

import '../main.dart';

class myMapScreen extends StatefulWidget {
  @override
  myMapState createState() => myMapState();

}

class myMapState extends State<myMapScreen> {

  PageController _pageController;
  GoogleMapController mapController;
  LatLng center = const LatLng(37.352727, -122.034227);
//  Location location = new Location();
  Position currentLocation;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarker
      );
    });

    currentLocation = currentLocation;
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _add(){
    final Marker marker = Marker(
      markerId: MarkerId("Event"),
      position: center,
      infoWindow: InfoWindow(title: "Event", snippet: '*'),
      onTap: () {
        print('tapped');
      },
    );
//                    _getLocation();
    setState(() {
      // adding a new marker to map
      markers[MarkerId("Event")] = marker;
    });
  }

  @override
  void initState() {
    markers.clear();
    super.initState();
    _pageController = PageController();
    _getLocation();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(
        backgroundColor: MyApp.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: MyApp.appBarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text(
                'Map View',
                style: TextStyle(
                    color: MyApp.whiteNoChangeColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    _getLocation();

                  },
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            )
          ],
        ),
        body: Container(
          height: sizingInformation.myScreenSize.height,
          width: sizingInformation.myScreenSize.width,
          child: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 15.0,
                ),
                myLocationEnabled: true,
                mapType: MapType.hybrid,
                compassEnabled: true,
                markers: Set<Marker>.of(markers.values),
          ),
              Positioned(
                child: FlatButton(
                  color: Colors.green,
                  child: Text("button"),
                  onPressed: (){
                    _add();
                  },
                ),
              )


            ],
          ),
        ),
      );
    },
    );
  }
}



