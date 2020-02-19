import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:permission/permission.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class myMapScreen extends StatefulWidget {
  final latitude, longitude;

  myMapScreen({@required this.latitude, @required this.longitude});

  @override
  myMapState createState() => myMapState();
}

class myMapState extends State<myMapScreen> {
  PageController _pageController;
  GoogleMapController mapController;
  Position currentLocation;

//  static const LatLng _center =  new LatLng(latitude, longitude);
//  LatLng _lastMapPosition = _center;

  final LatLng SOURCE = new LatLng(37.368832, -122.036346);
  final LatLng DEST = new LatLng(37.773972, -122.431297);
  final String API_KEY = "AIzaSyDqLE0Oj4XCxG8Gbv2SYZtpeRhDqtL5hXQ";

// static final LatLng _center = new LatLng(latitude, longitude);

  final Set<Polyline> _polyline = {};
  List<LatLng> routePoints;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDfIUawmqiyd4d4yiYrvgRzy3N8a_rmm70");
//  Set<Marker> _markers = {};
  List<Marker> _markers = <Marker>[];
  List<LatLng> route;


  @override
  void initState() {
    _markers.clear();
    super.initState();
    _pageController = PageController();
//   _getLocation();
    _add(DEST);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      _polyline.add(Polyline(
        polylineId: PolylineId('Route to Event'),
        visible: true,
        points: route,
        width: 4,
        color: Colors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap,
      ));
    });
  }

  void _add(LatLng destination) {
    final marker = Marker(
      markerId: MarkerId("event_loc"),
      position: destination,
      infoWindow: InfoWindow(title: 'Bay Section'),
      icon: BitmapDescriptor.defaultMarker,
      visible: true,
    );
    _markers.clear();
    _markers.add(marker);
  }

  // API CODE - DISTANCE MATRIX API //
  // https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Washington,DC&destinations=New+York+City,NY&key=AIzaSyDqLE0Oj4XCxG8Gbv2SYZtpeRhDqtL5hXQ
  Future<String> getData() async {
    var response = await http.get(
      "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=37.368832,-122.036346&destinations=37.773972%2C-122.431297&key=AIzaSyDqLE0Oj4XCxG8Gbv2SYZtpeRhDqtL5hXQ",
      headers: {
        "Accept": "application/json",
      }
    );
    Map<String, dynamic> data  = json.decode(response.body);
    List<dynamic> rows = data["rows"];
    print(rows[0]["elements"]);
    List<dynamic> elements = rows[0]["elements"];

    Map<String, dynamic> distance = elements[0]["distance"];
    Map<String, dynamic> duration = elements[0]["duration"];

    print(distance['text']);
    print(duration['text']);
    _getLocation();
  }

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    LatLng myLocation = LatLng(currentLocation.latitude,currentLocation.longitude);
    print('mylocation = ${myLocation.latitude}, ${myLocation.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
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
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    getData();
                  },
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ),
              )
            ],
          ),
          body: Container(
            height: sizingInformation.myScreenSize.height,
            width: sizingInformation.myScreenSize.width,
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  polylines: _polyline,
                  markers: Set<Marker>.of(_markers),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: SOURCE,
                    zoom: 5.0,
                  ),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  compassEnabled: true,
                ),
//                Positioned(
//                  child: FlatButton(
//                    color: Colors.green,
//                    child: Text("button"),
//                    onPressed: (){
//                    },
//                  ),
//                )
              ],
            ),
          ),
        );
      },
    );
  }
  void _drawRoute() async {
//    var permissions =
//        await Permission.getPermissionsStatus([PermissionName.Location]);
//    print(permissions[0].permissionStatus);
//    if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
//      await Permission.requestPermissions([PermissionName.Location]);
//    } else {
//      print('here');
//      routePoints = await googleMapPolyline.getCoordinatesWithLocation(
//        origin: SOURCE,
//        destination: DEST,
//        mode: RouteMode.driving,
//      );
////    routePoints = await googleMapPolyline.getPolylineCoordinatesWithAddress(
////        origin:  '55 Kingston Ave, Brooklyn, NY 11213, USA',
////        destination:  '8007 Cypress Ave, Glendale, NY 11385, USA',
////        mode:  RouteMode.driving);
//    }
//  LatLng myLocation = await _getLocation();
//    route = await googleMapPolyline.getCoordinatesWithLocation(
//        origin: myLocation,
//        destination: DEST,
//        mode:  RouteMode.driving);
//    routePoints.add(SOURCE);
//    routePoints.add(DEST);
  }
}
