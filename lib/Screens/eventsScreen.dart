import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/Screens/homeScreen.dart';
import 'package:mobile_app_dev/Screens/mapScreen.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/simple_round_button.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/main.dart';
import 'package:url_launcher/url_launcher.dart';

class eventScreen extends StatefulWidget {

  String eventName, eventDescription, eventDate, eventLocation, eventState, eventLink;
  Image eventImage;

  eventScreen({
    @required this.eventName,
    @required this.eventDescription,
    @required this.eventDate,
    @required this.eventLocation,
    @required this.eventState,
    @required this.eventLink,
    @required this.eventImage,
  });


  @override
  _eventScreenState createState() => _eventScreenState(
    eventDate: eventDate,
    eventDescription: eventDescription,
    eventImage: eventImage,
    eventLink: eventLink,
    eventName: eventName,
    eventLocation: eventLocation,
    eventState: eventState,
  );

}

class _eventScreenState extends State<eventScreen> {

  String eventName, eventDescription, eventDate, eventLocation, eventState, eventLink;
  Image eventImage;

  _eventScreenState({
    @required this.eventName,
    @required this.eventDescription,
    @required this.eventDate,
    @required this.eventLocation,
    @required this.eventState,
    @required this.eventLink,
    @required this.eventImage,
  });


  void _launch(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation){
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0.0),
                children: <Widget>[
                  Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: sizingInformation.myScreenSize.height ,
                      decoration: BoxDecoration(
                          color: MyApp.appBarColor,
                      ),
                    ),


                    Container(
                      height: sizingInformation.myScreenSize.height/3,
                      child: eventImage
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/15, right: sizingInformation.myScreenSize.width/15, top: sizingInformation.myScreenSize.height/20),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios, color: MyApp.whiteTextColor,)),
                          Spacer(),
                        ],
                      ),
                    ),

                    Positioned(
                      top: sizingInformation.myScreenSize.height/4,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: sizingInformation.myScreenSize.height,
                        decoration: BoxDecoration(
                            color: MyApp.backgroundColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            SizedBox(
                              height: sizingInformation.myScreenSize.height/25,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/10),
                              child: Text(eventName, style: TextStyle(
                                    color: MyApp.blackTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    fontFamily: 'OpenSans'
                                ),),
                            ),

                            SizedBox(
                              height: sizingInformation.myScreenSize.height/25,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/10, right: sizingInformation.myScreenSize.width/10),
                              child: Text(eventDescription, style: TextStyle(
                                  color: MyApp.blackTextColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  fontFamily: 'OpenSans'
                              ),),
                            ),

                            SizedBox(
                              height: sizingInformation.myScreenSize.height/25,
                            ),


                            Padding(
                              padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/10, right: sizingInformation.myScreenSize.width/10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Date : ", style: TextStyle(
                                      color: MyApp.blackTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'OpenSans'
                                  ),),
                                  Text(eventDate, style: TextStyle(
                                      color: MyApp.blackTextColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      fontFamily: 'OpenSans'
                                  ),),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: sizingInformation.myScreenSize.height/100,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/10, right: sizingInformation.myScreenSize.width/10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Location : ", style: TextStyle(
                                      color: MyApp.blackTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'OpenSans'
                                  ),),
                                  Text(eventLocation, style: TextStyle(
                                        color: MyApp.blackTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        fontFamily: 'OpenSans'
                                    ),),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: sizingInformation.myScreenSize.height/100,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/10, right: sizingInformation.myScreenSize.width/10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("State : ", style: TextStyle(
                                      color: MyApp.blackTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'OpenSans'
                                  ),),
                                  Text(eventState, style: TextStyle(
                                      color: MyApp.blackTextColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      fontFamily: 'OpenSans'
                                  ),),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: sizingInformation.myScreenSize.height/100,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/10, right: sizingInformation.myScreenSize.width/10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Website : ", style: TextStyle(
                                      color: MyApp.blackTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'OpenSans'
                                  ),),
                                  GestureDetector(
                                    onTap: (){
                                      _launch(eventLink);
                                    },
                                    child: Text("Link", style: TextStyle(
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        fontFamily: 'OpenSans'
                                    ),),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: sizingInformation.myScreenSize.height/25,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                GestureDetector(
                                  child: Container(
                                    height: sizingInformation.myScreenSize.height/10,
                                    width: sizingInformation.myScreenSize.width/2.5,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('Sign Up', style: TextStyle(color: MyApp.whiteNoChangeColor, fontWeight: FontWeight.w800),),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => myMapScreen()),);
                                  },
                                  child: Container(
                                    height: sizingInformation.myScreenSize.height/10,
                                    width: sizingInformation.myScreenSize.width/2.5,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('View On Map', style: TextStyle(color: MyApp.whiteNoChangeColor, fontWeight: FontWeight.w800),),
                                  ),
                                ),


                              ],
                            ),




                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ]),
            )
          ],
        ),

      );
    }
    );}
}