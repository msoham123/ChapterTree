//import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/Screens/mapScreen.dart';
import 'package:mobile_app_dev/Screens/pickChapter.dart';
import 'package:mobile_app_dev/UI/widgets.dart';

import 'models/appTheme.dart';

//void main() => runApp(DevicePreview(builder: (context) => MyApp()));
//activate for Device Preview

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  static var myEvents = [];

  static bool darkModeEnabled = false;
  static bool introSliderEnabled = true;
  static int currentIndex = 0;

  static Color backgroundColor = Colors.white;
  static Color curveColor = Colors.blueAccent;
  static Color whiteTextColor = Colors.white;
  static Color blackTextColor = Colors.black;
  static Color appBarColor = Colors.blue;
  static Color botBarColor = Colors.white;
  static Color whiteNoChangeColor = Colors.white;
  static Color blueGreyColor = Colors.blueGrey;
  static LinearGradient orangeGradient = LinearGradient(colors: [
    Colors.deepOrangeAccent,
    Colors.orangeAccent,
  ]);
  static LinearGradient blueGradient = LinearGradient(colors: [
    Colors.indigo[500],
    Colors.lightBlueAccent[100]
  ]);


  static void changeColor(val){
    if(val==true){
      backgroundColor = Colors.blueGrey[700];
      curveColor = Colors.grey;
      whiteTextColor = Colors.black;
      blackTextColor = Colors.white;
      appBarColor = Colors.blueGrey[900];
      botBarColor = Colors.blueGrey[900];
      blueGreyColor = Colors.white;
      orangeGradient = LinearGradient(colors: [
        Colors.black,
        Colors.black
      ]);
      blueGradient = LinearGradient(colors: [
        Colors.black,
        Colors.black
      ]);
    }else{
      backgroundColor = Colors.white;
      curveColor = Colors.blueAccent;
      whiteTextColor = Colors.white;
      blackTextColor = Colors.black;
      appBarColor = Colors.blue;
      blueGreyColor = Colors.blueGrey;
      botBarColor = Colors.white;
      orangeGradient = LinearGradient(colors: [
        Colors.deepOrangeAccent,
        Colors.orangeAccent,
      ]);
      blueGradient = LinearGradient(colors: [
        Colors.indigo[500],
        Colors.lightBlueAccent[100]
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
//      locale: DevicePreview.of(context).locale,
//      builder: DevicePreview.appBuilder,
        //activate for device preview
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.black,
            secondaryHeaderColor: Colors.orange,
            backgroundColor: Colors.white,
            textTheme: TextTheme(
                display1: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800, fontFamily: null)
            )
        ),
        home: myLoginScreen()
      ),
    );
  }
}

//    Navigator.push(context, MaterialPageRoute(bimport 'package:device_preview/device_preview.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:mobile_app_dev/Screens/loginScreen.dart';
//
////void main() => runApp(DevicePreview(builder: (context) => MyApp()));
////activate for Device Preview
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//    return MaterialApp(
////      locale: DevicePreview.of(context).locale,
////      builder: DevicePreview.appBuilder,
//    //activate for device preview
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primaryColor: Colors.black,
//        secondaryHeaderColor: Colors.orange,
//        backgroundColor: Colors.white,
//        textTheme: TextTheme(
//            display1: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800, fontFamily: null)
//        )
//      ),
//      home: myLoginScreen(),
//    );
//  }
//}
//
////    Navigator.push(context, MaterialPageRoute(builder: (context) => my));uilder: (context) => my));








