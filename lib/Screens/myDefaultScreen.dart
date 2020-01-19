import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/Screens/settingsScreen.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';

import 'eventScreen.dart';
import 'homeScreen.dart';
import 'messageScreen.dart';


class MyDefaultPage extends StatefulWidget {
  MyDefaultPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyDefaultPageState createState() => _MyDefaultPageState();
}

class _MyDefaultPageState extends State<MyDefaultPage> {
  int currentIndex = 0;
  int _counter = 0;
  PageController pageController;



  @override
  initState() {
    super.initState();
    pageController = new PageController(
      initialPage: currentIndex,
      keepPage: true,
      viewportFraction: 1,
    );
  }

  @override
  dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('ChapterTree'),
      ),
      body: Center(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: <Widget>[
              myHomeScreen(),
              myEventScreen(),
              myMessageScreen(),
              mySettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
          pageController.jumpToPage(index);
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.lightBlue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.assignment_ind),
            title: Text('Chapter'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text(
              'Messages',
            ),
            activeColor: Colors.green,
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