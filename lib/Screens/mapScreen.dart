import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_app_dev/Test/eventCards.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/events_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/widgets.dart';

import '../main.dart';

class myMapScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new myMapState();
  }
}

class myMapState extends State<myMapScreen>{
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
                'ChapterTree',
                style: TextStyle(
                    color: MyApp.whiteNoChangeColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Image.asset(
                'assets/images/treeicon.png',
                scale: 1.3,
              ),

              SizedBox(
                width: sizingInformation.myScreenSize.width/13,
              ),
            ],
          ),
          centerTitle: true,
          titleSpacing: 12,
          actions: <Widget>[
            //empty for now
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: sizingInformation.myScreenSize.height/30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: sizingInformation.myScreenSize.height/15,
                  width: sizingInformation.myScreenSize.width/1.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.deepOrangeAccent,
                      Colors.orangeAccent,
                    ]),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    'ChapterTree Event Map',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: sizingInformation.myScreenSize.height/30,
            ),

            Container(
              height: sizingInformation.myScreenSize.height/2,
              width: sizingInformation.myScreenSize.width/1,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return eventCard(sizingInformation,false);
                },
              ),
            ),






          ],
        ),
      );
    },);}}



