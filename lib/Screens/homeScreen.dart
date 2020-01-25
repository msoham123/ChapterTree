import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:mobile_app_dev/Test/eventCards.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/cards.dart';
import 'package:mobile_app_dev/UI/events_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:snaplist/snaplist.dart';

class myHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new myHomeState();
  }
}

class myHomeState extends State<myHomeScreen> {
  MediaQueryData myHeightPercent;
  PageController _pageController;
  Builder itemBuilder;

  Widget cardBuilder(SizingInformation sizingInformation) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < 10; i++) {
      list.add(
        CardWidget(
          sizingInformation,
          'SLC : California',
          'State Leadership Conference for the state of California.',
          Image.asset('assets/images/sacramento.png'),
        ),
      );
      list.add(
        Padding(
          padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: sizingInformation.myScreenSize.height / 15,
              bottom: 0),
        ),
      );
    }
<<<<<<< HEAD
    return new Column(children: list);
=======
    return new Row(children: list);

>>>>>>> 8fc7d6a89cb916bc422e5a1d202f71449396446e
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: sizingInformation.myScreenSize.height / 25,
                              bottom: 0)),
                      Center(
                        child: Text(
                          "My Events",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: sizingInformation.myScreenSize.height / 25,
                              bottom: 0)),
                      cardBuilder(sizingInformation),
                    ],
                  ),
=======
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: ListView(
                  children: <Widget>[

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/19,bottom:0)),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Competitive Events',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Container(
                      height: sizingInformation.myScreenSize.height/3,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return eventCard(sizingInformation);
                          },
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Calendar',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),

                    Container(
                        margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                            style: BorderStyle.solid,
                          )
                        ),
                        child: CalendarCarousel(
                          onDayPressed: (DateTime date, List<Event> events) {
                            this.setState(() => date = DateTime.now());
                          },
                          weekendTextStyle: TextStyle(
                            color: Colors.blueAccent,
                          ),
                          thisMonthDayBorderColor: Colors.grey,
                          customDayBuilder: (
                              bool isSelectable,
                              int index,
                              bool isSelectedDay,
                              bool isToday,
                              bool isPrevMonthDay,
                              TextStyle textStyle,
                              bool isNextMonthDay,
                              bool isThisMonthDay,
                              DateTime day,
                              ) {
                            return null;
                            /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                            /// This way you can build custom containers for specific days only, leaving rest as default.

                            // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
//                            if (day.day == 8) {
////                              return Center(
////                                child: Icon(Icons.map),
////                              );
////                            } else {
////                              return null;
////                            }
                          },
                          weekFormat: false,
                          markedDatesMap: null,
                          height: sizingInformation.myScreenSize.height/1.5,
                          selectedDateTime: DateTime.now(),
                          daysHaveCircularBorder: true, /// null for not rendering any border, true for circular border, false for rectangular border
                        ),
                      ),


                  ],
>>>>>>> 8fc7d6a89cb916bc422e5a1d202f71449396446e
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
