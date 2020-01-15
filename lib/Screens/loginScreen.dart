import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';

class myLoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new myLoginState();
  }
}

class myLoginState extends State<myLoginScreen>{

  MediaQueryData myHeightPercent;


  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
//        body: Center(
//          child: Text(
//            sizingInformation.toString(),
//            style: TextStyle(color : Theme.of(context).primaryColor),
//          ),
//        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                flexContainer(
                  myChild: Text("Hello World"),
                ),

              ],
            ),





          ],
        ),
      );
    },);}}