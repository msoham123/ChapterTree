import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:mobile_app_dev/Screens/navigation.dart';
import 'package:mobile_app_dev/Screens/signUp.dart';
import 'package:mobile_app_dev/Services/database.dart';
import 'package:mobile_app_dev/Test/introSlider.dart';
import 'package:mobile_app_dev/UI/background_widget.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/simple_round_button.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:mobile_app_dev/Utils/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:io' show Platform;
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

import '../main.dart';

DatabaseService ds;

class PickChapter extends StatefulWidget {
  String UID;
  FirebaseUser user;

  PickChapter(String UID, FirebaseUser user) {
    this.UID = UID;
    this.user = user;
  }

  @override
  State<StatefulWidget> createState() => PickChapterState();
}

class PickChapterState extends State<PickChapter> {
  String chapter = "", phone = "";

  final GoogleSignIn googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  MediaQueryData myHeightPercent;
  TextEditingController chapterController;
  String email = "", password = "";
  bool showSpinner = false;
  bool _officer = false;

  void initState() {
    super.initState();
  }

  void dispose() {
    chapterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
          backgroundColor: MyApp.backgroundColor,
          body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Stack(
              children: <Widget>[
                BackgroundWidget(sizingInformation),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: sizingInformation.myScreenSize.height / 10,
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: sizingInformation.myScreenSize.width / 10,
                            ),
                            Flexible(
                              child: Text(
                                "Join a chapter",
                                style: TextStyle(
                                    color: MyApp.whiteNoChangeColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800),
                              ),
                              fit: FlexFit.tight,
                              flex: 5,
                            ),
                            SizedBox(
                              width: sizingInformation.myScreenSize.width / 10,
                            ),
                            Flexible(
                              child: Image.asset(
                                'assets/images/chapterTree.png',
                                scale: 0.2,
                              ),
                              fit: FlexFit.tight,
                            ),
                            SizedBox(
                              width: sizingInformation.myScreenSize.width / 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizingInformation.myScreenSize.height / 7,
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset(
                            "./assets/images/pick_chapter.png",
                            height: sizingInformation.myScreenSize.height / 4,
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal:
                                    sizingInformation.myScreenSize.width / 10),
                            height: sizingInformation.myScreenSize.height / 10,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: MyApp.blueGradient,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: TextField(
                                obscureText: false,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.school,
                                    color: Colors.white,
                                  ),
                                  fillColor: Colors.white,
                                  labelText: null,
                                  hintText: "Chapter",
                                  labelStyle: null,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                                cursorWidth: 4,
                                cursorColor: Colors.white,
                                controller: chapterController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  chapter = value;
                                },
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal:
                                    sizingInformation.myScreenSize.width / 10),
                            height: sizingInformation.myScreenSize.height / 10,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: MyApp.blueGradient,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: TextField(
                                obscureText: false,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  fillColor: Colors.white,
                                  labelText: null,
                                  hintText: "Phone Number",
                                  labelStyle: null,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                                cursorWidth: 4,
                                cursorColor: Colors.white,
                                controller: chapterController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  phone = value;
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Officer : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              Checkbox(
                                value: _officer,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    _officer = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: sizingInformation.myScreenSize.width / 2.5,
                            child: SimpleRoundButton(
                              backgroundColor: MyApp.appBarColor,
                              buttonText: Text(
                                "NEXT",
                                style: kAuthButtonDecoration,
                              ),
                              onPressed: () async {
                                if ((phone.toString() != "" && chapter.toString() != "") || (phone.toString() != null && chapter.toString() != null)) {
                                  DocumentSnapshot documentSnapshot =
                                      await Firestore.instance
                                          .collection("fbla_users")
                                          .document(widget.UID)
                                          .get();

                                  int lastCount = 0;
                                  if (documentSnapshot.data != null) {
                                    if (documentSnapshot.data['count'] != 0) {
                                      lastCount =
                                          documentSnapshot.data['count'];
                                    }
                                  } else {
                                    print("Null");
                                  }

                                  ds =
                                      new DatabaseService(uid: widget.user.uid);
                                  ds.updateUserData(widget.user.displayName,
                                      lastCount, chapter, phone, _officer, []);

                                  if (MyApp.introSliderEnabled == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            IntroScreen(sizingInformation),
                                      ),
                                    );
                                    MyApp.introSliderEnabled = false;
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyDefaultPage(sizingInformation),
                                      ),
                                    );
                                  }
                                } else {
                                  _showError("Please fill in all fields");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  _showError(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(error),
        actions: <Widget>[
          FlatButton(
            child: Text("Back"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void sendSignUpMail(String email) async {
    var url =
        'https://us-central1-fbla2020-b50d0.cloudfunctions.net/sendMail?dest=$email';
    var httpClient = new HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        print("email success");
      }
    } catch (e) {
      print(e);
    }
  }
}
