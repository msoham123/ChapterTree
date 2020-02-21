import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:mobile_app_dev/Screens/navigation.dart';
import 'package:mobile_app_dev/Screens/signUp.dart';
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



import '../main.dart';

final LocalAuthentication _localAuthentication = LocalAuthentication();

class myLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => myLoginState();
}

class myLoginState extends State<myLoginScreen> {
  final _auth = FirebaseAuth.instance;
  MediaQueryData myHeightPercent;
  TextEditingController userController, passwordController;
  String email = "", password = "";
  bool showSpinner = false;


  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    try {
      _availableBiometricTypes = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

//    if (!mounted) return;

    print(_availableBiometricTypes);
  }

  Future<void> _authenticateUser(BuildContext context, SizingInformation sizingInformation) async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason:
        "Please authenticate to log-in",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

//   if (!mounted) return;

    isAuthenticated
        ? print('User is authenticated!')
        : print('User is not authenticated.');

    dynamic result = _auth.signInAnonymously();

    if(result == null) {
      print("error");
    } else {
      if(isAuthenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MyDefaultPage(sizingInformation),
          ),
        );
      }
    }
//    if (isAuthenticated) {
//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) =>
//              MyDefaultPage(sizingInformation),
//        ),
//      );
//    }
  }

  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 5), () => "1");
  }

  void initState() {
    super.initState();
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
          backgroundColor: MyApp.backgroundColor,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Stack(
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
                                "Welcome back, user!",
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
                                'assets/images/treeicon.png',
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
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.white,
                                labelText: null,
                                hintText: "Email",
                                labelStyle: null,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                              cursorWidth: 4,
                              cursorColor: Colors.white,
                              controller: userController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value;
                                print(email);
                              }),
                        ),
                      ),
                      SizedBox(
                        height: sizingInformation.myScreenSize.height / 22,
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
//                          maxLines: null,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  fillColor: Colors.white,
                                  labelText: null,
                                  hintText: "Password",
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
                                controller: passwordController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  password = value;
                                  print(password);
                                }),
                          )),
                      SizedBox(
                        height: sizingInformation.myScreenSize.height / 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: sizingInformation.myScreenSize.width / 2.5,
                            child: SimpleRoundButton(
                              backgroundColor: MyApp.appBarColor,
                              buttonText: Text(
                                "LOGIN",
                                style: kAuthButtonDecoration,
                              ),
                              onPressed: () async {
                                try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: password);
                                  this.setState(() {
                                    showSpinner = true;
                                  });
                                  if (user != null) {
                                    if(MyApp.introSliderEnabled==true){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              IntroScreen(sizingInformation),
                                        ),
                                      );
                                      MyApp.introSliderEnabled = false;
                                    }else{
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyDefaultPage(sizingInformation),
                                      ),
                                    );
                                    }
                                  }
                                } catch (e) {
                                  print(e);
                                  // Handle error
                                }
                              },
                            ),
                          ),

                          if(Platform.isIOS) Container(
                            width: sizingInformation.myScreenSize.width / 2.5,
                            child: SimpleRoundButton(
                              backgroundColor: MyApp.appBarColor,
                              buttonText: Text(
                                "FACE ID",
                                style: kAuthButtonDecoration,
                              ),
                              onPressed: () async {
                                print("Face ID Login Request");

                                await _getListOfBiometricTypes();

                                  if (_availableBiometricTypes.contains(BiometricType.face)) {
                                    await _authenticateUser(context, sizingInformation);
                                  }
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: sizingInformation.myScreenSize.width / 1.3,
                        child: SimpleRoundButton(
                          backgroundColor: MyApp.backgroundColor,
                          buttonText: Text(
                            'Sign up for an account',
                            style: TextStyle(
                                color: MyApp.blueGreyColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => mySignUpScreen(),
                              ),
                            );
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
