import 'package:flutter/cupertino.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/Screens/navigation.dart';
import 'package:mobile_app_dev/Test/toggleSwitch.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/simple_round_button.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:mobile_app_dev/UI/events_widget.dart';
import 'package:mobile_app_dev/main.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mobile_app_dev/UI/flare_button_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class mySettingsScreen extends StatefulWidget {
  @override
  _mySettingsState createState() => _mySettingsState();
}

class _mySettingsState extends State<mySettingsScreen> {
  MediaQueryData myHeightPercent;
  PageController _pageController;
  String _message = '';

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


  void _launch(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
          backgroundColor: MyApp.backgroundColor,
          body: Column(
            children: <Widget>[

              SizedBox(height: 18.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Application Settings',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: MyApp.blackTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.0),
              Container(
                child: Column(
                  children: <Widget>[

                    mySwitch(
                      title: "Dark Mode",
                      switchValue: MyApp.darkModeEnabled,
                      valueChanged: (value) {
                        MyApp.darkModeEnabled = value;
                        MyApp.changeColor(MyApp.darkModeEnabled);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyDefaultPage(sizingInformation)),);
                        print(MyApp.darkModeEnabled);
                        },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Social Media',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: MyApp.blackTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print('Instagram tapped');
                      _launch('https://www.instagram.com/fbla_pbl/?hl=en');
                    },
                    child: Icon(
                      FontAwesome5Brands.instagram,
                      color: Colors.pink,
                      size: 50.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Facebook tapped');
                      _launch('https://www.facebook.com/FutureBusinessLeaders/');
                    },
                    child: Icon(
                      FontAwesome5Brands.facebook,
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Twitter tapped');
                      _launch('https://twitter.com/fbla_national?lang=en');
                    },
                    child: Icon(
                      FontAwesome5Brands.twitter,
                      color: Colors.lightBlueAccent,
                      size: 50.0,
                    ),
                  )
                ],
              ),

              SizedBox(
                height: sizingInformation.myScreenSize.height/20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                        print('send sms');
                        List<String> recipients = ["14086371215"];
                        _sendSMS("Hello!", recipients);
                    },
                    child: Text('Send SMS', style: TextStyle(color: Colors.white),),
                    color: Colors.blue
                  )
                ],
              ),

              SizedBox(
                height: sizingInformation.myScreenSize.height/20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'My Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: MyApp.blackTextColor,
                    ),
                  ),
                ],
              ),


              Container(
                width: sizingInformation.myScreenSize.width/1.3,
                child: SimpleRoundButton(
                  backgroundColor: Colors.red,
                  buttonText: Text('Sign Out of My Account', style: TextStyle(color: MyApp.blackTextColor),),
                  onPressed: () {
//                          MyDefaultPageState._auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => myLoginScreen(),
                      ),
                    );
                  },
                ),
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
