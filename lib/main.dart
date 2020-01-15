import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';



void main() => runApp(DevicePreview(builder: (context) => MyApp()));

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        secondaryHeaderColor: Colors.orange,
        backgroundColor: Colors.white,
      ),
      home: myLoginScreen(),
    );
  }
}

//    Navigator.push(context, MaterialPageRoute(builder: (context) => my));








