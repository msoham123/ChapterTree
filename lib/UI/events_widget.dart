import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';

class Event extends StatelessWidget {
  Function onPressed;
  SizingInformation sizingInformation;
  Text titleText, descriptionText;
  Widget myWidget;

//  SizingInformation sizingInformation, Function onPressed, Icon myIcon, Text buttonText
  Event({
    this.sizingInformation,
    this.onPressed,
    this.myWidget,
    this.titleText,
    this.descriptionText,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: sizingInformation.myScreenSize.width/13),
        height: sizingInformation.myScreenSize.height/4,
        decoration: BoxDecoration(
            border: Border.all(color : Colors.black, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/100,bottom:0)),

            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              height: sizingInformation.myScreenSize.height/12,
              width: sizingInformation.myScreenSize.width/1.1,
              child: titleText,
            ),

            Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/60,bottom:0)),

            Expanded(
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/40,right: 0,top: 0,bottom:0)),

                  Flexible(
                    child: Container(
                      child: descriptionText,
                    ),
                  ),

                  Container(
                    child: myWidget,
                  ),

                  Padding(padding: EdgeInsets.only(left: 0,right: sizingInformation.myScreenSize.width/40,top: 0,bottom:0)),

                ],
              ),
              ),

            Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/60,bottom:0)),
          ],
        ),
      ),
    );
  }
}












//    return Container(
//      color: backgroundColor,
//      alignment: Alignment.center,
//      child :  Stack(
//        children: <Widget>[
//          FlatButton(
//            color: Colors.transparent,
//            child: myIcon,
//            onPressed: (){},
//
//          ),
//
//          FlatButton(
//            padding: const EdgeInsets.only(left: 0,top: 130 * myHomeState.heightVal , right: 0, bottom: 0),
//            color: Colors.transparent,
//            textColor: textColor,
//            child: buttonText,
//            onPressed: (){},
//
//          ),
//
//
//
//
//        ],
//      ),
//    );
//  }
//}