import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/Screens/myDefaultScreen.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:mobile_app_dev/UI/events_widget.dart';

class mySettingsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new mySettingsState();
  }
}

class mySettingsState extends State<mySettingsScreen>{
  MediaQueryData myHeightPercent;

  PageController _pageController;

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

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: ListView(
                  children: <Widget>[

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Center(
                      child : Text("My Profile", style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w800),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text("User", style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w800)),
                          ),
                          Flexible(
                            child: Icon(Icons.person, size: 20),
                          ),
                        ],
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),




                  ],
                ),
              ),
            ),





          ],
        ),
      );
    },);}}



