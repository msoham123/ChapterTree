import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/Screens/navigation.dart';
import 'package:mobile_app_dev/Services/database.dart';
import 'package:mobile_app_dev/Test/toggleSwitch.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/simple_round_button.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:mobile_app_dev/UI/events_widget.dart';
import 'package:mobile_app_dev/main.dart';
import 'package:mobile_app_dev/models/eventListModel.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mobile_app_dev/UI/flare_button_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

// CREATE INSTANCE ON CURRENT FIREBASE LOOGED IN USER
FirebaseUser loggedInUser;
String name = '', chapter = '', phoneNumber = '', email = '';
final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

class mySettingsScreen extends StatefulWidget {
  @override
  _mySettingsState createState() => _mySettingsState();
}

class _mySettingsState extends State<mySettingsScreen> {
  MediaQueryData myHeightPercent;
  PageController _pageController;
  DatabaseService ds;
  DocumentSnapshot userSnapshot;
  List<String> phones = new List<String>();
  bool isOfficer;
  String uid = '';
  List events;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    ds = new DatabaseService();
    getCurrentUser();
    _populateCurrentUser(loggedInUser);
    _getPhoneNumbers();
  }

  // GET CURRENT LOGGED IN USER

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // POPULATE CURRENT USER INFORMATION

  Future<void> _populateCurrentUser(FirebaseUser user) async {
    final FirebaseUser user = await _auth.currentUser();
    final String userUID = user.uid.toString();
    if (user != null) {
      userSnapshot = await ds.getUser(userUID);
    }
    name = userSnapshot.data['full_name'].toString();
    chapter = userSnapshot.data['chapter'].toString();
    phoneNumber = userSnapshot.data['phone'].toString();
    email = loggedInUser.email;
    isOfficer = userSnapshot.data['isOfficer'];
    uid = loggedInUser.uid;
    events = userSnapshot.data['events'];
    print(isOfficer);
  }

  // GET ALL THE USERS IN ONE'S CHAPTER FOR SENDING SMS
  Future<List<String>> _getPhoneNumbers() async {
    final result = await _firestore
        .collection("fbla_users")
        .where("chapter", isEqualTo: chapter)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    phones.clear();
    documents.forEach((data) => phones.add(data.data['phone']));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _launch(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // SEND SMS TO ALL MEMBERS IN A CHAPTER
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  // GET ALL THE EVENTS THE USER IS SIGNED UP FOR
  void getEvents() async {
    events = await ds.getSignedUpEvents(uid);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
          backgroundColor: MyApp.backgroundColor,
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 18.0),
                    FutureBuilder(
                        future: _populateCurrentUser(loggedInUser),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      sizingInformation.myScreenSize.width / 30,
                                  right: sizingInformation.myScreenSize.width /
                                      30),
                              child: Container(
                                height:
                                    sizingInformation.myScreenSize.height / 2.00,
                                decoration: BoxDecoration(
                                  color: MyApp.backgroundColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    )
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 18.0),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: sizingInformation
                                                  .myScreenSize.width /
                                              30,
                                          right: sizingInformation
                                                  .myScreenSize.width /
                                              30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: MyApp.blackTextColor,
                                                width: 2),
                                            shape: BoxShape.circle),
                                        child: CircleAvatar(
                                          child: Text(
                                            name.substring(0, 1),
                                            style: TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          maxRadius: 30.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 18.0),
                                    Text(
                                      name,
                                      style: TextStyle(
                                          color: MyApp.blackTextColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 18.0),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: sizingInformation
                                                  .myScreenSize.width /
                                              10,
                                          right: sizingInformation
                                                  .myScreenSize.width /
                                              10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Chapter : ",
                                            style: TextStyle(
                                                color: MyApp.blackTextColor,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            chapter,
                                            style: TextStyle(
                                                color: MyApp.blackTextColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 18.0),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: sizingInformation
                                                  .myScreenSize.width /
                                              10,
                                          right: sizingInformation
                                                  .myScreenSize.width /
                                              10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Email : ",
                                            style: TextStyle(
                                                color: MyApp.blackTextColor,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            email,
                                            style: TextStyle(
                                                color: MyApp.blackTextColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 18.0),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: sizingInformation
                                                  .myScreenSize.width /
                                              10,
                                          right: sizingInformation
                                                  .myScreenSize.width /
                                              10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Phone Number : ",
                                            style: TextStyle(
                                                color: MyApp.blackTextColor,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            phoneNumber,
                                            style: TextStyle(
                                                color: MyApp.blackTextColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 18.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          "Events Signed up For: ",
                                          style: TextStyle(
                                              color: MyApp.blackTextColor,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 18.0),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: sizingInformation
                                                  .myScreenSize.width /
                                              10,
                                          right: sizingInformation
                                                  .myScreenSize.width /
                                              10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Flexible(
                                            child: Center(
                                              child: Text(
                                                '$events',
                                                style: TextStyle(
                                                  color: MyApp.blackTextColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    SizedBox(height: 18.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Application Settings',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: MyApp.blackTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.0),
                    Container(
                      child: Column(
                        children: <Widget>[
                          mySwitch(
                            title: "Dark Mode",
                            switchValue: MyApp.darkModeEnabled,
                            valueChanged: (value) {
                              MyApp.darkModeEnabled = value;
                              MyApp.changeColor(MyApp.darkModeEnabled);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyDefaultPage(sizingInformation)),
                              );
                              print(MyApp.darkModeEnabled);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Social Media',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: MyApp.blackTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print('Instagram tapped');
                            _launch(
                                'https://www.instagram.com/fbla_pbl/?hl=en');
                          },
                          child: Icon(
                            FontAwesome5Brands.instagram,
                            color: Colors.pink,
                            size: 50.0,
                          ),
                        ),
                        // SOCIAL MEDIA
                        GestureDetector(
                          onTap: () {
                            print('Facebook tapped');
                            _launch(
                                'https://www.facebook.com/FutureBusinessLeaders/');
                          },
                          child: Icon(
                            FontAwesome5Brands.facebook,
                            color: Colors.blue,
                            size: 50.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Twitter tapped');
                            _launch(
                                'https://twitter.com/fbla_national?lang=en');
                          },
                          child: Icon(
                            FontAwesome5Brands.twitter,
                            color: Colors.lightBlueAccent,
                            size: 50.0,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: sizingInformation.myScreenSize.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FutureBuilder(
                          future: _populateCurrentUser(loggedInUser),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return FutureBuilder(
                                future: _getPhoneNumbers(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Visibility(
                                      visible: isOfficer,
                                      child: MaterialButton(
                                        onPressed: () {
                                          // SENDING SMS HERE
                                          _sendSMS(
                                              "FBLA Meeting Today!", phones);
                                        },
                                        child: Text(
                                          'Notify Meeting Alert',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.blue,
                                      ),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: sizingInformation.myScreenSize.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'My Account',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: MyApp.blackTextColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: sizingInformation.myScreenSize.width / 1.3,
                      child: SimpleRoundButton(
                        backgroundColor: Colors.red,
                        buttonText: Text(
                          'Sign Out of My Account',
                          style: TextStyle(color: MyApp.blackTextColor),
                        ),
                        onPressed: () {
//                          MyDefaultPageState._auth.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => myLoginScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: sizingInformation.myScreenSize.height / 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//Scaffold(
//body: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Expanded(
//child: Container(
//alignment: Alignment.center,
//color: Colors.white,
//child: ListView(
//children: <Widget>[
//Padding(
//padding: EdgeInsets.only(
//left: 0,
//right: 0,
//top: sizingInformation.myScreenSize.height / 25,
//bottom: 0)),
//
//
//Padding(
//padding: EdgeInsets.only(
//left: 0,
//right: 0,
//top: sizingInformation.myScreenSize.height / 25,
//bottom: 0)),
//],
//),
//),
//),
//],
//),
//          body: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                  alignment: Alignment.center,
//                  color: Colors.white,
//                  child: ListView(
//                    children: <Widget>[
//                      Padding(
//                          padding: EdgeInsets.only(
//                              left: 0,
//                              right: 0,
//                              top: sizingInformation.myScreenSize.height / 25,
//                              bottom: 0)),
//
//
//                      Padding(
//                          padding: EdgeInsets.only(
//                              left: 0,
//                              right: 0,
//                              top: sizingInformation.myScreenSize.height / 25,
//                              bottom: 0)),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//);
