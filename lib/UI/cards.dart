import 'package:flutter/material.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';

class CardWidget extends StatelessWidget {
  SizingInformation sizingInformation;
  String title, description;
  Image myImage;

  CardWidget(SizingInformation sizingInformation, String title, String description, Image myImage){
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
        gradient: LinearGradient(colors: [
          Colors.indigo[500],
          Colors.lightBlueAccent[100]
        ]),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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

          myImage,

          Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/30,bottom:0)),

          Text(
            description,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/50,bottom:0)),


          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 0,right: sizingInformation.myScreenSize.width/15,top: 0,bottom:0)),

              Flexible(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 11.0),
                  color: Colors.lightBlueAccent,
                  onPressed: () {},
                  child: Text(
                    'Favorite',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(9.0),
                      side: BorderSide(color: Colors.white)),
                ),
              ),

              Padding(padding: EdgeInsets.only(left: 0,right: sizingInformation.myScreenSize.width/12,top: 0,bottom:0)),

              Flexible(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 11.0),
                  color: Colors.green,
                  onPressed: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(9.0),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

