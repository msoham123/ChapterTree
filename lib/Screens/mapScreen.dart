import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:permission/permission.dart';
import 'package:mobile_app_dev/models/distanceduration.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class myMapScreen extends StatefulWidget {
  LatLng DEST;
  String title;
  double startLat, startLong;

  myMapScreen(
      {@required this.DEST,
      @required this.title,
      @required this.startLat,
      @required this.startLong
      });

  @override
  myMapState createState() =>
      myMapState(DEST, title, startLat, startLong);
}

class myMapState extends State<myMapScreen> {
  PageController _pageController;
  GoogleMapController mapController;
  Position currentLocation;
  LatLng SOURCE;
  DistanceDuration distance, duration;
  String origin = '', destination = '';
  final String API_KEY = "AIzaSyDqLE0Oj4XCxG8Gbv2SYZtpeRhDqtL5hXQ";

  String title;
  LatLng DEST;
  double startLat, startLong, endLat, endLong;

  myMapState(LatLng DEST, String title, double startLat, double startLong) {
    this.DEST = DEST;
    this.title = title;
    this.startLat = startLat;
    this.startLong = startLong;
  }

  final Set<Polyline> _polyline = {};
  List<LatLng> routePoints;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDfIUawmqiyd4d4yiYrvgRzy3N8a_rmm70");

//  Set<Marker> _markers = {};
  List<Marker> _markers = <Marker>[];
  List<LatLng> route;
  bool isLoad = false;

  @override
  void initState() {
    _markers.clear();
    super.initState();
    _pageController = PageController();
//   _getLocation();
    _add(DEST);
    _populateSource();
    getData();
  }

  void _populateSource() async {
    SOURCE = await _getSource();
    isLoad = true;
  }

  Future<LatLng> _getSource() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    LatLng myLocation =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    print('mylocation = ${myLocation.latitude}, ${myLocation.longitude}');
    return myLocation;
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
      infoWindow: InfoWindow(title: title),
      icon: BitmapDescriptor.defaultMarker,
      visible: true,
    );
    _markers.clear();
    _markers.add(marker);
  }

  // API CODE - DISTANCE MATRIX API //
  // https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Washington,DC&destinations=New+York+City,NY&key=AIzaSyDqLE0Oj4XCxG8Gbv2SYZtpeRhDqtL5hXQ
  void getData() async {
    var response = await http.get(
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${startLat},${startLong}&destinations=${DEST.latitude}%2C${DEST.longitude}&key=AIzaSyDqLE0Oj4XCxG8Gbv2SYZtpeRhDqtL5hXQ',
        headers: {
          "Accept": "application/json",
        });
    Map<String, dynamic> data = json.decode(response.body);
    origin = data["origin_addresses"][0];
    destination = data["destination_addresses"][0];

    List<dynamic> rows = data["rows"];
    print(rows[0]["elements"]);
    List<dynamic> elements = rows[0]["elements"];

    distance = DistanceDuration.fromMap(elements[0]["distance"]);
    duration = DistanceDuration.fromMap(elements[0]["duration"]);
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
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: MyApp.backgroundColor,
                            title: Center(
                              child: Text(
                                'Location Details',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            content: Container(
                              height: sizingInformation.myScreenSize.height / 2,
                              width: sizingInformation.myScreenSize.width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${origin}',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      Icon(Icons.keyboard_arrow_down),
                                      Text(
                                        '${destination}',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      SizedBox(
                                        height: sizingInformation
                                                .myScreenSize.height /
                                            15,
                                      ),
                                      Icon(
                                        Icons.time_to_leave,
                                        size: 40.0,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        distance.text,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        duration.text,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _openMaps(DEST.latitude, DEST.longitude);
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 190,
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color: Colors.green.withOpacity(0.8),
                                              blurRadius: 2.0,
                                              spreadRadius: 4.0,
                                            )
                                          ]),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                child: Image.asset(
                                                  'assets/images/map.png',
                                                )
                                              ),
                                              Text('Open with MAPS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      RaisedButton(
                                        color: Colors.blue,
                                        child: Text("Back",
                                            style: TextStyle(
                                                color: MyApp.whiteTextColor)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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
//                isLoad == false ?
//                    Center(child: CircularProgressIndicator()):
                GoogleMap(
                  polylines: _polyline,
                  markers: Set<Marker>.of(_markers),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.368832, -122.036346),
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

  void _openMaps(double lat, double long) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
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
