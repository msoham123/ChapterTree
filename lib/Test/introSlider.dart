import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/Screens/navigation.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';

class IntroScreen extends StatefulWidget{

  SizingInformation sizingInformation;

  IntroScreen(SizingInformation sizingInformation){
    this.sizingInformation = sizingInformation;
  }


  @override
  IntroScreenState createState(){
    return IntroScreenState(sizingInformation);
  }
}


class IntroScreenState extends State<IntroScreen> {
  SizingInformation sizingInformation;
  List<Slide> slides = new List();

  IntroScreenState(SizingInformation sizingInformation){
    this.sizingInformation = sizingInformation;
  }

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Sign Up for Events",
        description: "Keep track of all of your competitive events to ensure that you succeed!",
        pathImage: "assets/images/eventsPic.png",
        backgroundColor: Colors.blue,
      ),
    );
    slides.add(
      new Slide(
        title: "Chapter Attendance",
        description: "Record data on chapter member attendance.",
        pathImage: "assets/images/attendancePic.png",
        backgroundColor: Colors.green,
      ),
    );
    slides.add(
      new Slide(
        title: "Learn About FBLA",
        description:
        "Learn about the rich and intuitive history, mission, and features of FBLA.",
        pathImage: "assets/images/fblaPic.png",
        backgroundColor: Colors.red,
      ),
    );
    slides.add(
      new Slide(
        title: "Communication",
        description:
        "Conference with other FBLA members for strategies, study sessions, and more!",
        pathImage: "assets/images/messagePic.png",
        backgroundColor: Colors.orange,
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MyDefaultPage(sizingInformation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroSlider(
        slides: this.slides,
        onDonePress: this.onDonePress,
      ),
    );
  }
}