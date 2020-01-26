import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/Screens/navigation.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:mobile_app_dev/UI/events_widget.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mobile_app_dev/UI/flare_button_animation.dart';

class mySettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => mySettingsState();
}

class mySettingsState extends State<mySettingsScreen> {
  MediaQueryData myHeightPercent;
  PageController _pageController;
  bool switchValue = true;
  bool isOpen = false;

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
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//Scaffold(
//body: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Expanded(
//child: Container(
//alignment: Alignment.center,
//color: Colors.white,
//child: ListView(
//children: <Widget>[
//Padding(
//padding: EdgeInsets.only(
//left: 0,
//right: 0,
//top: sizingInformation.myScreenSize.height / 25,
//bottom: 0)),
//
//
//Padding(
//padding: EdgeInsets.only(
//left: 0,
//right: 0,
//top: sizingInformation.myScreenSize.height / 25,
//bottom: 0)),
//],
//),
//),
//),
//],
//),
//          body: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  alignment: Alignment.center,
//                  color: Colors.white,
//                  child: ListView(
//                    children: <Widget>[
//                      Padding(
//                          padding: EdgeInsets.only(
//                              left: 0,
//                              right: 0,
//                              top: sizingInformation.myScreenSize.height / 25,
//                              bottom: 0)),
//
//
//                      Padding(
//                          padding: EdgeInsets.only(
//                              left: 0,
//                              right: 0,
//                              top: sizingInformation.myScreenSize.height / 25,
//                              bottom: 0)),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//);
