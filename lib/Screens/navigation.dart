import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/Screens/settingsScreen.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_dev/Utils/constants.dart';
import 'package:mobile_app_dev/Screens/questionScreen.dart';
import 'package:mobile_app_dev/Screens/my_chapter.dart';

import '../main.dart';
import 'mapScreen.dart';
import 'homeScreen.dart';
import 'messageScreen.dart';

FirebaseUser loggedInUser;

class MyDefaultPage extends StatefulWidget {
  SizingInformation sizingInformation;

  MyDefaultPage(SizingInformation sizingInformation) {
    this.sizingInformation = sizingInformation;
  }

  @override
  _MyDefaultPageState createState() => _MyDefaultPageState(sizingInformation);
}

class _MyDefaultPageState extends State<MyDefaultPage> {
  PageController pageController;
  SizingInformation sizingInformation;
  final _auth = FirebaseAuth.instance;

  _MyDefaultPageState(SizingInformation sizingInformation) {
    this.sizingInformation = sizingInformation;
  }

  @override
  initState() {
    super.initState();
    pageController = new PageController(
        initialPage: MyApp.currentIndex, keepPage: true, viewportFraction: 1);
    getCurrentUser();
  }

  @override
  dispose() {
    pageController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyApp.appBarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: sizingInformation.myScreenSize.width/15,
            ),
            Text(
              'ChapterTree',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Image.asset(
              'assets/images/treeicon.png',
              scale: 1.3,
            ),
          ],
        ),
        centerTitle: true,
        titleSpacing: 12,
        actions: <Widget>[
          //empty for now
        ],
      ),
      body: Center(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              MyApp.currentIndex = index;
            });
          },
          children: <Widget>[
            myHomeScreen(),
            myChapterScreen(),
            myMessageScreen(),
            myQuestionScreen(),
            mySettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        selectedIndex: MyApp.currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) {
          setState(() {
            MyApp.currentIndex = index;
          });
          pageController.jumpToPage(index);
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.assignment_ind),
            title: Text('Chapter'),
            activeColor: Colors.redAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.question_answer),
            title: Text(
              'Messages',
            ),
            activeColor: Colors.green,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.live_help),
            title: Text('Questions'),
            activeColor: Colors.orangeAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.black,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
