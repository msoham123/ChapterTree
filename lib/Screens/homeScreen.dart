import 'package:flutter/rendering.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:mobile_app_dev/Screens/eventsScreen.dart';
import 'package:mobile_app_dev/Test/eventCards.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/cards.dart';
import 'package:mobile_app_dev/UI/simple_round_button.dart';
import 'package:mobile_app_dev/UI/simple_round_only_icon_button.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:mobile_app_dev/models/eventListModel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_dev/models/user.dart';
import 'package:mobile_app_dev/Services/database.dart';

import '../main.dart';

class myHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new myHomeState();
  }
}

class myHomeState extends State<myHomeScreen> {
  MediaQueryData myHeightPercent;
  PageController _pageController;
  TextEditingController _textEventController;
  CalendarController _calendarController;

  Map<DateTime, List<dynamic>> _events;
  SharedPreferences prefs;
  List<dynamic> _selectedEvents;

  Builder itemBuilder;
  final _db = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  DocumentSnapshot userSnapshot;
  DatabaseService ds = new DatabaseService();

  bool isOfficer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _calendarController = CalendarController();
    _textEventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    getCurrentUser();
    _populateCurrentUser(loggedInUser);
    initPrefs();
  }

  Future<bool> _load() async {
    return isOfficer;
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

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

  void _populateCurrentUser(FirebaseUser user) async {
    final FirebaseUser user = await _auth.currentUser();
    final String userUID = user.uid.toString();
    if (user != null) {
      userSnapshot = await ds.getUser(userUID);
    }
    isOfficer = userSnapshot['isOfficer'];
    print(userSnapshot.data['chapter']);
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return BaseWidget(
          builder: (context, sizingInformation) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      color: MyApp.backgroundColor,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: sizingInformation.myScreenSize.height / 60,
                          ),
                          Container(
                            width: sizingInformation.myScreenSize.width / 1.3,
                            child: SimpleRoundButton(
                              backgroundColor: MyApp.appBarColor,
                              buttonText: Text(
                                'My Events',
                                style:
                                    TextStyle(color: MyApp.whiteNoChangeColor),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: MyApp.backgroundColor,
                                      title: Center(
                                          child: Text('Your Events',
                                              style: TextStyle(
                                                  color:
                                                      MyApp.blackTextColor))),
                                      content: Container(
                                        height: sizingInformation
                                                .myScreenSize.height /
                                            1.8,
                                        width: sizingInformation
                                                .myScreenSize.width /
                                            1.3,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    MyApp.myEvents.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return eventCard(
                                                      sizingInformation,
                                                      MyApp.myEvents[index]);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: sizingInformation
                                                      .myScreenSize.height /
                                                  130,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                RaisedButton(
                                                  color: Colors.blue,
                                                  child: Text(
                                                    "Back",
                                                    style: TextStyle(
                                                        color: MyApp
                                                            .whiteTextColor),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: sizingInformation.myScreenSize.height / 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Competitive Events',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    color: MyApp.blackTextColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sizingInformation.myScreenSize.height / 30,
                          ),
                          Container(
                            height: sizingInformation.myScreenSize.height / 3,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: FBLAEventModel.CaliforniaEvents.length,
                              itemBuilder: (BuildContext context, int index) {
                                return eventCard(
                                  sizingInformation,
                                  FBLAEventModel.CaliforniaEvents[index],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                              height:
                                  sizingInformation.myScreenSize.height / 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Calendar',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: MyApp.blackTextColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              TableCalendar(
                                events: _events,
                                initialCalendarFormat: CalendarFormat.month,
                                calendarStyle: CalendarStyle(
                                  todayColor: Colors.green,
                                  todayStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                  selectedColor: Colors.lightGreen,
                                ),
                                headerStyle: HeaderStyle(
                                  formatButtonDecoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  formatButtonTextStyle:
                                      TextStyle(color: Colors.white),
                                ),
                                onDaySelected: (date, events) {
                                  setState(() {
                                    _selectedEvents = events;
                                  });
                                  print(_selectedEvents);
                                },
                                calendarController: _calendarController,
                              ),
                              ..._selectedEvents.map(
                                (event) => ListTile(
                                  title: Text(event.toString()),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: sizingInformation.myScreenSize.height / 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FutureBuilder(
                                future: _load(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      child: Visibility(
                                        visible: isOfficer,
                                        child: RawMaterialButton(
                                          onPressed: _showAddDialog,
                                          child: new Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 35.0,
                                          ),
                                          shape: new CircleBorder(),
                                          elevation: 2.0,
                                          fillColor: Colors.blue,
                                          padding: const EdgeInsets.all(15.0),
                                        ),
                                      ),
                                      margin: EdgeInsets.only(
                                          right: 5.0, bottom: 20.0),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _textEventController,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Save"),
            onPressed: () {
              if (_textEventController.text.isEmpty) return;

              if (_events[_calendarController.selectedDay] != null) {
                _events[_calendarController.selectedDay]
                    .add(_textEventController.text);
              } else {
                _events[_calendarController.selectedDay] = [
                  _textEventController.text
                ];
              }
              setState(() {});
              Navigator.pop(context);
              prefs.setString("events", json.encode(encodeMap(_events)));
              _textEventController.clear();
            },
          )
        ],
      ),
    );
  }
}
