import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/Screens/Navigation.dart';
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

class mySignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => mySignUpState();
}

class mySignUpState extends State<mySignUpScreen> {
  final _auth = FirebaseAuth.instance;
  MediaQueryData myHeightPercent;
  TextEditingController userController, passwordController;
  String email = "", password = "";
  bool showSpinner = false;

  void initState() {
    super.initState();
    userController = TextEditingController();
    passwordController = TextEditingController();
  }

  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
          backgroundColor: Colors.white,
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

//                      Container(
//                        child : Image.asset(
//                            'images/logo1.png',
//                          height: sizingInformation.myScreenSize.height/3.3 ,
//                          width: sizingInformation.myScreenSize.width/1.3,
//                        ),
//                      ),

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

                      Padding(
                          padding: EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: sizingInformation.myScreenSize.height / 7,
                              bottom: 0)),

                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal:
                                  sizingInformation.myScreenSize.width / 10),
                          height: sizingInformation.myScreenSize.height / 10,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.indigo[500],
                                Colors.lightBlueAccent[100]
                              ]), //indigo 500
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
                                  hintText: 'Please enter an email',
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
                                controller: userController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  email = value;
                                }),
                          )),

                      Padding(
                          padding: EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: sizingInformation.myScreenSize.height / 22,
                              bottom: 0)),

                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal:
                                  sizingInformation.myScreenSize.width / 10),
                          height: sizingInformation.myScreenSize.height / 10,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.indigo[500],
                                Colors.lightBlueAccent[100]
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: TextField(
                              textAlign: TextAlign.left,
//                          maxLines: null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.white,
                                labelText: null,
                                hintText: 'Choose a password',
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

                      Padding(
                          padding: EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: sizingInformation.myScreenSize.height / 22,
                              bottom: 0)),

                      Container(
                        width: sizingInformation.myScreenSize.width / 1.5,
                        child: SimpleRoundButton(
                          buttonText: Text(
                            'Sign Me Up!',
                            style: kAuthButtonDecoration,
                          ),
                          backgroundColor: Colors.blueAccent,
                          onPressed: () async {
                            // Create the user here once we have the email and password
                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              if (newUser != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MyDefaultPage(sizingInformation),
                                  ),
                                );

                                showDialog(
                                    context: context,
                                    builder: (_) => AssetGiffyDialog(
                                          description: Text(
                                              'To confirm, your email will be $email, and your password will be $password. You will be able to change the password later.'),
                                          title: Text("Welcome to ChapterTree"),
                                          onOkButtonPressed: () =>
                                              Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyDefaultPage(
                                                      sizingInformation),
                                            ),
                                          ),
                                          entryAnimation: EntryAnimation.BOTTOM,
                                          image: Image.asset(
                                              'assets/gifs/welcome.gif'),
                                        ));

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
                          backgroundColor: Colors.white,
                          buttonText: Text(
                            'Never mind',
                            style: TextStyle(
                                color: Colors.blueGrey,
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
      },
    );
  }
}

//
//Container(
//alignment: Alignment.center,
//width: sizingInformation.myScreenSize.width/1.3,
//height: sizingInformation.myScreenSize.height/4,
//decoration: BoxDecoration(
//color: Colors.white,
//gradient: LinearGradient(
//colors : [Colors.indigo[500], Colors.lightBlueAccent[100] ]),
//borderRadius: BorderRadius.all(Radius.circular(30)),
//),
//child: Image.asset('images/logo1.png'),
//),
