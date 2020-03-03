import 'package:mobile_app_dev/Screens/navigation.dart';
import 'package:mobile_app_dev/Screens/settingsScreen.dart';
import 'package:mobile_app_dev/Services/database.dart';
import 'package:mobile_app_dev/Test/introSlider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/background_widget.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/simple_round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_dev/Utils/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';

class myChangeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => myChangeState();
}

class myChangeState extends State<myChangeScreen> {
  final _auth = FirebaseAuth.instance;
  MediaQueryData myHeightPercent;
  TextEditingController nameController, chapterController, phoneController;

  String name = "", phone = "", chapter = "";
  String previousName = "", previousPhone = "", previousChapter = "";
  bool isOfficer;
  FirebaseUser loggedInUser;
  bool showSpinner = false;

  void initState() {
    isOfficer = false;
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    chapterController = TextEditingController();
    getCurrentUser();
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    chapterController.dispose();
    super.dispose();
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        DocumentSnapshot documentSnapshot = await Firestore.instance
            .collection("fbla_users")
            .document(loggedInUser.uid)
            .get();
        nameController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: documentSnapshot.data['full_name']))
            .value;
        phoneController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: documentSnapshot.data['phone']))
            .value;
        chapterController.value = new TextEditingController.fromValue(
                new TextEditingValue(text: documentSnapshot.data['chapter']))
            .value;
//      isOfficer = documentSnapshot.data['isOfficer'];
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  backgroundColor: MyApp.appBarColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: MyApp.whiteNoChangeColor,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: sizingInformation.myScreenSize.width/7,
                      )
                    ],
                  ),
                ),
                backgroundColor: MyApp.backgroundColor,
                body: ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: sizingInformation.myScreenSize.height /
                                  18,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal:
                                  sizingInformation.myScreenSize.width / 10),
                              height: sizingInformation.myScreenSize.height /
                                  10,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: MyApp.blueGradient, //indigo 500
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                                ),
                                child: TextField(
                                    textAlign: TextAlign.left,
//                          maxLines: null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                      fillColor: Colors.white,
                                      labelText: null,
                                      hintText: 'Full Name',
                                      labelStyle: null,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                    cursorWidth: 4,
                                    cursorColor: Colors.white,
                                    controller: nameController,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      name = value;
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: sizingInformation.myScreenSize.height / 49,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal:
                                  sizingInformation.myScreenSize.width / 10),
                              height: sizingInformation.myScreenSize.height /
                                  10,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: MyApp.blueGradient, //indigo 500
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                                ),
                                child: TextField(
                                    textAlign: TextAlign.left,
//                          maxLines: null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                      fillColor: Colors.white,
                                      labelText: null,
                                      hintText: 'Phone Number ',
                                      labelStyle: null,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                    cursorWidth: 4,
                                    cursorColor: Colors.white,
                                    controller: phoneController,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      phone = value;
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: sizingInformation.myScreenSize.height / 49,
                            ),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal:
                                    sizingInformation.myScreenSize.width / 10),
                                height: sizingInformation.myScreenSize.height /
                                    10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: MyApp.blueGradient, //indigo 500
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: TextField(
                                      textAlign: TextAlign.left,
//                          maxLines: null,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.school,
                                          color: Colors.white,
                                        ),
                                        fillColor: Colors.white,
                                        labelText: null,
                                        hintText: 'Chapter (e.g Fremont)',
                                        labelStyle: null,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                      cursorWidth: 4,
                                      cursorColor: Colors.white,
                                      controller: chapterController,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        chapter = value;
                                      }),
                                )),
                            SizedBox(
                              height: sizingInformation.myScreenSize.height / 49,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Officer : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Checkbox(
                                  value: isOfficer,
                                  onChanged: (value) {
                                    setState(() {
                                      isOfficer = value;
                                    });
                                  },
                                ),
                              ],
                            ),

                            Container(
                              width: sizingInformation.myScreenSize.width / 1.5,
                              child: SimpleRoundButton(
                                  buttonText: Text(
                                    'Change Profile',
                                    style: kAuthButtonDecoration,
                                  ),
                                  backgroundColor: MyApp.appBarColor,
                                  onPressed: () async {
                                    if (nameController.text != "" &&
                                        phoneController.text != "" &&
                                        chapterController.text != "") {
                                      // Update user information
                                      try {
                                        DatabaseService ds =
                                        new DatabaseService(
                                            uid: loggedInUser.uid);
                                        DocumentSnapshot documentSnapshot =
                                        await Firestore.instance
                                            .collection("fbla_users")
                                            .document(loggedInUser.uid)
                                            .get();
                                        List<String> events = documentSnapshot
                                            .data['events']
                                            .cast<String>();
                                        int count =
                                        documentSnapshot.data['count'];
                                        ds.updateUserData(
                                            nameController.text,
                                            count,
                                            chapterController.text,
                                            phoneController.text,
                                            isOfficer,
                                            events);
                                        Navigator.pop(context);
                                      } catch (e) {
                                        // Handle the exception here!
                                        print(e.toString());
                                        if (e.toString() ==
                                            "PlatformException(ERROR_WEAK_PASSWORD, The password must be 6 characters long or more., null)") {
                                          _showError(
                                              "Enter a stronger password. Must be 6 characters long or more");
                                        } else if (e.toString() ==
                                            "PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)") {
                                          _showError(
                                              "Email not properly formatted");
                                        }
                                      }
                                    } else {
                                      _showError("Please fill in all fields");
                                    }
                                  }
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }



  /*

  onPressed: () async {
                                      if (nameController.text != "" &&
                                          phoneController.text != "" &&
                                          chapterController.text != "") {
                                        // Update user information
                                        try {
                                          DatabaseService ds =
                                              new DatabaseService(
                                                  uid: loggedInUser.uid);
                                          DocumentSnapshot documentSnapshot =
                                              await Firestore.instance
                                                  .collection("fbla_users")
                                                  .document(loggedInUser.uid)
                                                  .get();
                                          List<String> events = documentSnapshot
                                              .data['events']
                                              .cast<String>();
                                          int count =
                                              documentSnapshot.data['count'];
                                          ds.updateUserData(
                                              nameController.text,
                                              count,
                                              chapterController.text,
                                              phoneController.text,
                                              isOfficer,
                                              events);
                                          Navigator.pop(context);
                                        } catch (e) {
                                          // Handle the exception here!
                                          print(e.toString());
                                          if (e.toString() ==
                                              "PlatformException(ERROR_WEAK_PASSWORD, The password must be 6 characters long or more., null)") {
                                            _showError(
                                                "Enter a stronger password. Must be 6 characters long or more");
                                          } else if (e.toString() ==
                                              "PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)") {
                                            _showError(
                                                "Email not properly formatted");
                                          }
                                        }
                                      } else {
                                        _showError("Please fill in all fields");
                                      }
                                    }
   */


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
            ));
  }
}
