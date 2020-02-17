import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_app_dev/Test/eventCards.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/events_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/widgets.dart';

import '../main.dart';

class myMapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new myMapState();
  }
}

class myMapState extends State<myMapScreen> {
  PageController _pageController;
  GoogleMapController mapController;
  final LatLng _center = const LatLng(37.352727, -122.034227);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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

              SizedBox(
                width: sizingInformation.myScreenSize.width/8,
              ),
            ],
          ),
          centerTitle: true,
          actions: <Widget>[
            //empty for now
          ],
        ),
        body: Container(
          height: sizingInformation.myScreenSize.height,
          width: sizingInformation.myScreenSize.width,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 10.0,
            ),
          ),
        ),
      );
    },
    );
  }
}



