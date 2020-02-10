import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/Utils/ui_utils.dart';

import '../main.dart';

class BackgroundWidget extends StatelessWidget{
  SizingInformation sizingInformation;

  BackgroundWidget(SizingInformation sizingInformation){
    this.sizingInformation = sizingInformation;
  }

  @override
  Widget build(BuildContext context) {

//    return Container(
//      decoration: BoxDecoration(
//        gradient: LinearGradient(
//          colors: [Colors.cyan[200], Colors.cyan[700]]
////            colors: [Colors.lightBlueAccent[100], Colors.indigo[500]]
//        ),
//      ),
//    );

    return ClipPath(
      clipper: BottomShapeClipper(sizingInformation),
      child: Container(
        decoration: BoxDecoration(
        color: MyApp.appBarColor,
          ),
        ),
      );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  SizingInformation sizingInformation;

  BottomShapeClipper(SizingInformation sizingInformation){
    this.sizingInformation = sizingInformation;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartPoint = Offset(0, sizingInformation.myScreenSize.height/4.5);
    Offset curveEndPoint = Offset(sizingInformation.myScreenSize.width, sizingInformation.myScreenSize.height/4.5);
    path.lineTo(curveStartPoint.dx, curveStartPoint.dy);
    path.quadraticBezierTo(sizingInformation.myScreenSize.width/2, sizingInformation.myScreenSize.height/3, curveEndPoint.dx, curveEndPoint.dy);
    path.lineTo(sizingInformation.myScreenSize.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
