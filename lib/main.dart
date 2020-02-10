import 'package:device_preview/device_preview.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/UI/widgets.dart';

import 'models/appTheme.dart';

//void main() => runApp(DevicePreview(builder: (context) => MyApp()));
//activate for Device Preview

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  static bool darkModeEnabled = false;
  static int currentIndex = 0;

  static Color backgroundColor = Colors.white;
  static Color curveColor = Colors.blueAccent;
  static Color whiteTextColor = Colors.white;
  static Color blackTextColor = Colors.black;
  static Color appBarColor = Colors.blue;

  static void changeColor(val){
    if(val==true){
      backgroundColor = Colors.white10;
      curveColor = Colors.white10;
      whiteTextColor = Colors.black;
      blackTextColor = Colors.white;
      appBarColor = Colors.black;
    }else{
      backgroundColor = Colors.white;
      curveColor = Colors.blueAccent;
      whiteTextColor = Colors.white;
      blackTextColor = Colors.black;
      appBarColor = Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
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
      home: myLoginScreen(),
    );
  }
}

//    Navigator.push(context, MaterialPageRoute(builder: (context) => my));








