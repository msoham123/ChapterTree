import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_app_dev/Screens/homeScreen.dart';
import 'package:mobile_app_dev/Screens/mapScreen.dart';
import 'package:mobile_app_dev/Screens/navigation.dart';
import 'package:mobile_app_dev/Services/database.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/main.dart';
import 'package:mobile_app_dev/models/eventListModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';


class eventScreen extends StatefulWidget {
  String eventName,
      eventDescription,
      eventDate,
      eventLocation,
      eventState,
      eventLink;
  Image eventImage;
  LatLng DEST;
  var localOfficers = [];
  var localOfficerPositions = [];

  //  EVENT SCREEN PARAMETERS
  eventScreen({
    @required this.eventName,
    @required this.eventDescription,
    @required this.eventDate,
    @required this.eventLocation,
    @required this.eventState,
    @required this.eventLink,
    @required this.eventImage,
    @required this.DEST,
    @required this.localOfficers,
    @required this.localOfficerPositions,
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
        DEST: DEST,
        localOfficerPositions : localOfficerPositions,
        localOfficers : localOfficers,
      );
}



class _eventScreenState extends State<eventScreen> {
  String eventName,
      eventDescription,
      eventDate,
      eventLocation,
      eventState,
      eventLink;
  Image eventImage;
  LatLng DEST;
  var localOfficers = [];
  var localOfficerPositions = [];

  // Initialize firebase instance
  final _auth = FirebaseAuth.instance;

  // Create an instance of a firebase user
  FirebaseUser loggedInUser;

  String uid = '';

  // Declare DatabaseService for database handling
  DatabaseService ds;

  _eventScreenState({
    @required this.eventName,
    @required this.eventDescription,
    @required this.eventDate,
    @required this.eventLocation,
    @required this.eventState,
    @required this.eventLink,
    @required this.eventImage,
    @required this.DEST,
    @required this.localOfficers,
    @required this.localOfficerPositions,
  });

  // Initialize current state of screen
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ds = new DatabaseService();
    // Get the current logged in user
    getCurrentUser();
  }

  // Get the current logged in user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        uid = loggedInUser.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  // Launch method to open up google maps in the app
  void _launch(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Widget to build officer information for each competitive event
  Widget officerBuilder(SizingInformation sizingInformation){
  List<Widget> myList = [];
  for(int i=0;i<localOfficers.length;i++){
    myList.add(
      Padding(
        padding: EdgeInsets.only(
            left:
            sizingInformation.myScreenSize.width / 10,
            right: sizingInformation.myScreenSize.width /
                10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "${localOfficerPositions[i]} : ",
              style: TextStyle(
                  color: MyApp.blackTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'OpenSans'),
            ),
            Text(
              localOfficers[i],
              style: TextStyle(
                  color: MyApp.blackTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  fontFamily: 'OpenSans'),
            ),
            SizedBox(
              height:
              sizingInformation.myScreenSize.height / 25,
            ),
          ],
        ),
      )
    );
  }

    return Column(
      children: myList,
    );
  }

  // Widget to build information on each event
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: sizingInformation.myScreenSize.height*1.4,
                decoration: BoxDecoration(
                  color: MyApp.appBarColor,
                ),
              ),
              Positioned(
                child: Container(
                    height: sizingInformation.myScreenSize.height / 3,
                    width: sizingInformation.myScreenSize.width,
                    child: eventImage),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: sizingInformation.myScreenSize.width / 15,
                    right: sizingInformation.myScreenSize.width / 15,
                    top: sizingInformation.myScreenSize.height / 20),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: MyApp.whiteTextColor,
                        )),
                    Spacer(),
                  ],
                ),
              ),
              Positioned(
                top: sizingInformation.myScreenSize.height / 4,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: sizingInformation.myScreenSize.height,
                  decoration: BoxDecoration(
                      color: MyApp.backgroundColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height:
                            sizingInformation.myScreenSize.height / 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: sizingInformation.myScreenSize.width /
                                10),
                        child: Text(
                          eventName,
                          style: TextStyle(
                              color: MyApp.blackTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: 'OpenSans'),
                        ),
                      ),
                      SizedBox(
                        height:
                            sizingInformation.myScreenSize.height / 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                sizingInformation.myScreenSize.width / 10,
                            right: sizingInformation.myScreenSize.width /
                                10),
                        child: Text(
                          eventDescription,
                          style: TextStyle(
                              color: MyApp.blackTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: 'OpenSans'),
                        ),
                      ),
                      SizedBox(
                        height:
                            sizingInformation.myScreenSize.height / 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                sizingInformation.myScreenSize.width / 10,
                            right: sizingInformation.myScreenSize.width /
                                10),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Date : ",
                              style: TextStyle(
                                  color: MyApp.blackTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'OpenSans'),
                            ),
                            Text(
                              eventDate,
                              style: TextStyle(
                                  color: MyApp.blackTextColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  fontFamily: 'OpenSans'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            sizingInformation.myScreenSize.height / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                sizingInformation.myScreenSize.width / 10,
                            right: sizingInformation.myScreenSize.width /
                                10),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Location : ",
                              style: TextStyle(
                                  color: MyApp.blackTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'OpenSans'),
                            ),
                            Text(
                              eventLocation,
                              style: TextStyle(
                                  color: MyApp.blackTextColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  fontFamily: 'OpenSans'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            sizingInformation.myScreenSize.height / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                sizingInformation.myScreenSize.width / 10,
                            right: sizingInformation.myScreenSize.width /
                                10),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "State : ",
                              style: TextStyle(
                                  color: MyApp.blackTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'OpenSans'),
                            ),
                            Text(
                              eventState,
                              style: TextStyle(
                                  color: MyApp.blackTextColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  fontFamily: 'OpenSans'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            sizingInformation.myScreenSize.height / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                sizingInformation.myScreenSize.width / 10,
                            right: sizingInformation.myScreenSize.width /
                                10),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Website : ",
                              style: TextStyle(
                                  color: MyApp.blackTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'OpenSans'),
                            ),
                            GestureDetector(
                              onTap: () {
                                _launch(eventLink);
                              },
                              child: Text(
                                "Link",
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    fontFamily: 'OpenSans'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            sizingInformation.myScreenSize.height / 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                            GestureDetector(
                            onTap: () {
                              // REMOVING EVENT
                              String dialog;
                              if (events.contains(eventName)/*MyApp.myEvents.contains(FBLAEventModel.CaliforniaEvents[FBLAEventModel.CaliforniaIndex.indexOf(eventName)])*/){
                               dialog = "Event Removed";

                               ds.removeEvent(eventName, uid);
                              }
                              else {
                                // ADDING EVENT
                                dialog = "$eventName added to My Events!";
                                MyApp.myEvents.add(FBLAEventModel
                                    .CaliforniaEvents[FBLAEventModel
                                    .CaliforniaIndex.indexOf(eventName)]);

                                ds.addEvent(eventName, uid);
                              }
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                        backgroundColor: MyApp.backgroundColor,
                                        content: Container(
                                          height: sizingInformation.myScreenSize.height/4,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(dialog),
                                              SizedBox(
                                                height: sizingInformation.myScreenSize.height/15,
                                              ),
                                              RaisedButton(
                                                color: Colors.blue,
                                                child: Text("Okay",style: TextStyle(color: MyApp.whiteTextColor)),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18),
                                                ),
                                                onPressed: () {
                                                  dialog=="Event Removed" ? MyApp.myEvents.remove(FBLAEventModel
                                                      .CaliforniaEvents[FBLAEventModel
                                                      .CaliforniaIndex.indexOf(eventName)]) : print("Event added");
//                                                  Navigator.pop(context);
//                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => MyDefaultPage(sizingInformation)),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                    );
                                  }
                              );
                            },
                            child: Container(
                              height:
                                  sizingInformation.myScreenSize.height /
                                      15,
                              width:
                                  sizingInformation.myScreenSize.width /
                                      2.5,
                              decoration: BoxDecoration(
                               color: (events.contains(eventName)) ? Colors.red : Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.launch,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (events.contains(eventName))
                                    Text(
                                    'Remove Event',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: MyApp.whiteNoChangeColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
//                                  if (!MyApp.myEvents.contains(FBLAEventModel.CaliforniaEvents[FBLAEventModel.CaliforniaIndex.indexOf(eventName)]))
                                  if (!events.contains(eventName))
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: MyApp.whiteNoChangeColor,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => myMapScreen(DEST: DEST,title: eventName, startLat: 38.368832, startLong: -123.036346))
                              );
                            },
                            child: Container(
                              height:
                                  sizingInformation.myScreenSize.height /
                                      15,
                              width:
                                  sizingInformation.myScreenSize.width /
                                      2.5,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.map,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'View On Map',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: MyApp.whiteNoChangeColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                        sizingInformation.myScreenSize.height / 25,
                      ),
                      GestureDetector(
                        onTap: () async {
                          print("Sharing with friends");
                          share(context, eventName);
                        },
                        child: Center(
                          child: Container(
                            height:
                            sizingInformation.myScreenSize.height /
                                15,
                            width:
                            sizingInformation.myScreenSize.width /
                                2.2,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    FontAwesome5Brands.telegram_plane,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                                  Text(
                                    'Share with friends',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: MyApp.whiteNoChangeColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                        sizingInformation.myScreenSize.height / 25,
                      ),
                      Container(
                        child: officerBuilder(sizingInformation),
                      ),
                    ],
                  ),
                ),
              ),
//              Positioned(
//                top: sizingInformation.myScreenSize.height,
//                width: sizingInformation.myScreenSize.width,
//                height: sizingInformation.myScreenSize.width,
//                child: Container(color: Colors.red),
//              ),
            ],
          ),
        ),
      );
    });
  }
  void share(BuildContext context, String event) {
     final String text = 'I am signing up for $event';
     Share.share(text, subject: text);
  }
}
