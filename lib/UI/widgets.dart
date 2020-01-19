
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget myBottomBar(){
  var _selectedIndex;
  return BottomNavyBar(
    selectedIndex: _selectedIndex,
    showElevation: true, // use this to remove appBar's elevation
    onItemSelected: (index) => setState(() {
      _selectedIndex = index;
//      _pageController.animateToPage(index,
//          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }),
    items: [
      BottomNavyBarItem(
        icon: Icon(Icons.apps),
        title: Text('Home'),
        activeColor: Colors.red,
      ),
      BottomNavyBarItem(
          icon: Icon(Icons.people),
          title: Text('Users'),
          activeColor: Colors.purpleAccent
      ),
      BottomNavyBarItem(
          icon: Icon(Icons.message),
          title: Text('Messages'),
          activeColor: Colors.pink
      ),
      BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Colors.blue
      ),
    ],
  );



}

setState(Null Function() param0) {
}

