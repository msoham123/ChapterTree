import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/events_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:snaplist/snaplist.dart';

class myHomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new myHomeState();
  }
}

class myHomeState extends State<myHomeScreen>{
  MediaQueryData myHeightPercent;

  PageController _pageController;

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
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: ListView(
                  children: <Widget>[

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Center(
                      child : Text("My Events", style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w800),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Event(
                      titleText: Text("California Bay Section", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),),
                      descriptionText: Text("A prestigious event where the schools battle it out.", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),),
                      myWidget: Image.asset('assets/images/sacramento.png'),
                      sizingInformation: sizingInformation,
                      onPressed: (){},
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Event(
                      titleText: Text("California Bay Section", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),),
                      descriptionText: Text("A prestigious event where the schools battle it out.", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),),
                      myWidget: Image.asset('assets/images/sacramento.png'),
                      sizingInformation: sizingInformation,
                      onPressed: (){},
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Event(
                      titleText: Text("California Bay Section", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),),
                      descriptionText: Text("A prestigious event where the schools battle it out.", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),),
                      myWidget: Image.asset('assets/images/sacramento.png'),
                      sizingInformation: sizingInformation,
                      onPressed: (){},
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Event(
                      titleText: Text("California Bay Section", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),),
                      descriptionText: Text("A prestigious event where the schools battle it out.", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),),
                      myWidget: Image.asset('assets/images/sacramento.png'),
                      sizingInformation: sizingInformation,
                      onPressed: (){},
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Event(
                      titleText: Text("California Bay Section", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),),
                      descriptionText: Text("A prestigious event where the schools battle it out.", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),),
                      myWidget: Image.asset('assets/images/sacramento.png'),
                      sizingInformation: sizingInformation,
                      onPressed: (){},
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Event(
                      titleText: Text("California Bay Section", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),),
                      descriptionText: Text("A prestigious event where the schools battle it out.", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),),
                      myWidget: Image.asset('assets/images/sacramento.png'),
                      sizingInformation: sizingInformation,
                      onPressed: (){},
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Event(
                      titleText: Text("California Bay Section", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),),
                      descriptionText: Text("A prestigious event where the schools battle it out.", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),),
                      myWidget: Image.asset('assets/images/sacramento.png'),
                      sizingInformation: sizingInformation,
                      onPressed: (){},
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },);}}

