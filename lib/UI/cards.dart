import 'package:flutter/material.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';

import '../main.dart';

class CardWidget extends StatelessWidget {
  SizingInformation sizingInformation;
  String title, description;
  Widget myImage;

  CardWidget(SizingInformation sizingInformation, String title, String description, Widget myImage){
    this.sizingInformation = sizingInformation;
    this.title = title;
    this.description = description;
    this.myImage = myImage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizingInformation.myScreenSize.width/13),
      width: sizingInformation.myScreenSize.width/1.25,
      padding: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        gradient: MyApp.orangeGradient,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

        ],
      ),
    );
  }
}

