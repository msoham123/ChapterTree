import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/Screens/navigation.dart';
import 'package:mobile_app_dev/Services/database.dart';
import 'package:mobile_app_dev/Test/introSlider.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/background_widget.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/simple_round_button.dart';
import 'package:mobile_app_dev/UI/simple_round_icon_button.dart';
import 'package:mobile_app_dev/UI/simple_round_only_icon_button.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_dev/Utils/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mobile_app_dev/Utils/constants.dart';
import 'package:mobile_app_dev/Services/database.dart';

import '../main.dart';

class mySignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => mySignUpState();
}

class mySignUpState extends State<mySignUpScreen> {
  final _auth = FirebaseAuth.instance;

  MediaQueryData myHeightPercent;
  TextEditingController emailController,
      passwordController,
      nameController,
      chapterController,
      phoneController;
  String email = "", password = "", name = "", chapter = "", phone = "";
  bool showSpinner = false;
  bool isOfficer;

  void initState() {
    isOfficer = false;
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    chapterController = TextEditingController();
  }

  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    chapterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
        return Scaffold(
          backgroundColor: MyApp.backgroundColor,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Stack(
              children: <Widget>[
                BackgroundWidget(sizingInformation),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: sizingInformation.myScreenSize.height / 10,
                              bottom: 0)),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      sizingInformation.myScreenSize.width / 10,
                                  right: 0,
                                  top: 0,
                                  bottom: 0),
                            ),
                            Flexible(
                              child: Text(
                                "Create an account",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800),
                              ),
                              fit: FlexFit.tight,
                              flex: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      sizingInformation.myScreenSize.width / 10,
                                  right: 0,
                                  top: 0,
                                  bottom: 0),
                            ),
                            Flexible(
                              child: Image.asset(
                                'assets/images/treeicon.png',
                                scale: 0.2,
                              ),
                              fit: FlexFit.tight,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      sizingInformation.myScreenSize.width / 10,
                                  right: 0,
                                  top: 0,
                                  bottom: 0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizingInformation.myScreenSize.height / 10,
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
                            gradient: MyApp.blueGradient, //indigo 500
                            borderRadius: BorderRadius.all(Radius.circular(30)),
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
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                              cursorWidth: 4,
                              cursorColor: Colors.white,
                              controller: nameController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                name = value;
                              }),
                        ),
                      ),
//                      SizedBox(
//                        height: sizingInformation.myScreenSize.height / 69,
//                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal:
                                  sizingInformation.myScreenSize.width / 10),
                          height: sizingInformation.myScreenSize.height / 10,
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
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  fillColor: Colors.white,
                                  labelText: null,
                                  hintText: 'Email',
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
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  email = value;
                                }),
                          )),
//                      SizedBox(
//                        height: sizingInformation.myScreenSize.height / 69,
//                      ),
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
                              obscureText: true,
                              textAlign: TextAlign.left,
//                          maxLines: null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.white,
                                labelText: null,
                                hintText: 'Password',
                                labelStyle: null,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                              cursorWidth: 4,
                              cursorColor: Colors.white,
                              controller: passwordController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                          )),
//                      SizedBox(
//                        height: sizingInformation.myScreenSize.height / 69,
//                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal:
                            sizingInformation.myScreenSize.width / 10),
                        height: sizingInformation.myScreenSize.height / 10,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: MyApp.blueGradient, //indigo 500
                            borderRadius: BorderRadius.all(Radius.circular(30)),
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
                              style:
                              TextStyle(fontSize: 25, color: Colors.white),
                              cursorWidth: 4,
                              cursorColor: Colors.white,
                              controller: phoneController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                phone = value;
                              }),
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Officer : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
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
                            'Sign Me Up!',
                            style: kAuthButtonDecoration,
                          ),
                          backgroundColor: MyApp.appBarColor,
                          onPressed: () async {
                            // Create the user here once we have the email and password
                            try {
                              // TRY TO CREATE A USER IN THE FIREBASE AUTHENTICATION DATABASE
                              final result =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              FirebaseUser user = result.user;

                              // Create a document for the user with the uid
                              await DatabaseService(uid: user.uid).updateUserData(name, 0, chapter, phone, isOfficer, []);

                              if (result != null) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AssetGiffyDialog(
                                    description: Text(
                                        'To confirm, your email will be $email, and your password will be $password. You will be able to change the password later.'),
                                    title: Text("Welcome to ChapterTree"),
                                    onOkButtonPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyDefaultPage(sizingInformation),
                                      ),
                                    ),
                                    entryAnimation: EntryAnimation.BOTTOM,
                                    image:
                                        Image.asset('assets/gifs/welcome.gif'),
                                  ),
                                );
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
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                              // Handle the exception here!
                            }
                          },
                        ),
                      ),
                      Container(
                        width: sizingInformation.myScreenSize.width / 1.3,
                        child: SimpleRoundButton(
                          backgroundColor: MyApp.backgroundColor,
                          buttonText: Text(
                            'Never mind',
                            style: TextStyle(
                                color: MyApp.blueGreyColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
}
