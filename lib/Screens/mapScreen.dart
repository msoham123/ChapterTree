import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:permission/permission.dart';

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

// static final LatLng _center = new LatLng(latitude, longitude);

  final Set<Polyline> _polylines = {};
  List<LatLng> routePoints;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDfIUawmqiyd4d4yiYrvgRzy3N8a_rmm70");
//  Set<Marker> _markers = {};
  List<Marker> _markers = <Marker>[];


  @override
  void initState() {
    _markers.clear();
    super.initState();
    _pageController = PageController();
//   _getLocation();
    _drawRoute();
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
//      _polylines.add(
//        Polyline(
//          polylineId: PolylineId("Route1"),
//          visible: true,
//          points: routePoints,
//          width: 10,
//          color: Colors.blue,
//          startCap: Cap.roundCap,
//          endCap: Cap.buttCap,
//        ),
//      );
    });
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

    routePoints.add(SOURCE);
    routePoints.add(DEST);
  }

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
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

                    },
                    child: Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  ))
            ],
          ),
          body: Container(
            height: sizingInformation.myScreenSize.height,
            width: sizingInformation.myScreenSize.width,
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  polylines: _polylines,
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
}
