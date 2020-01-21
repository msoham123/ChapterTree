import 'package:mobile_app_dev/Screens/myDefaultScreen.dart';
import 'package:mobile_app_dev/Screens/signUp.dart';
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

class myLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new myLoginState();
  }
}

class myLoginState extends State<myLoginScreen> {
  MediaQueryData myHeightPercent;
  TextEditingController userController, passwordController;

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
//        body: Center(
//          child: Text(
//            sizingInformation.toString(),
//            style: TextStyle(color : Theme.of(context).primaryColor),
//          ),
//        ),
          body: Stack(
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
                                left: sizingInformation.myScreenSize.width / 10,
                                right: 0,
                                top: 0,
                                bottom: 0),
                          ),
                          Flexible(
                            child: Text(
                              "Welcome back, user!",
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
                                left: sizingInformation.myScreenSize.width / 10,
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
                                left: sizingInformation.myScreenSize.width / 10,
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
                              hintText: null,
                              labelStyle: null,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
//                            hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
                            ),
                            style: TextStyle(fontSize: 25, color: Colors.white),
                            cursorWidth: 4,
                            cursorColor: Colors.white,
                            controller: userController,
                            keyboardType: TextInputType.emailAddress,
                          ),
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
                            borderRadius: BorderRadius.all(Radius.circular(30)),
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
                              hintText: null,
                              labelStyle: null,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
//                            hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
                            ),
                            style: TextStyle(fontSize: 25, color: Colors.white),
                            cursorWidth: 4,
                            cursorColor: Colors.white,
                            controller: passwordController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        )),

                    Padding(
                        padding: EdgeInsets.only(
                            left: 0,
                            right: 0,
                            top: sizingInformation.myScreenSize.height / 22,
                            bottom: 0)),

                    Container(
                      width: sizingInformation.myScreenSize.width / 1.3,
                      child: SimpleRoundOnlyIconButton(
                        icon: Icon(Icons.keyboard_tab),
                        iconColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyDefaultPage(sizingInformation)));
                        },
                      ),
                    ),

                    Container(
                      width: sizingInformation.myScreenSize.width / 1.3,
                      child: SimpleRoundButton(
                        backgroundColor: Colors.white,
                        buttonText: Text(
                          'Sign up for an account',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w800,
                              fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => mySignUpScreen()));
                        },
                      ),
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
