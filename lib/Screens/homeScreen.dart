import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_app_dev/Screens/eventsScreen.dart';
import 'package:mobile_app_dev/Screens/mapScreen.dart';
import 'package:mobile_app_dev/Test/eventCards.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/cards.dart';
import 'package:mobile_app_dev/UI/events_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/simple_round_button.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:snaplist/snaplist.dart';

import '../main.dart';

class myHomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new myHomeState();
  }
}

class myHomeState extends State<myHomeScreen>{
  MediaQueryData myHeightPercent;
  PageController _pageController;
  Builder itemBuilder;



  Widget cardBuilder(SizingInformation sizingInformation, bool isRow){
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < 10; i++){
      list.add(CardWidget(sizingInformation, 'SLC : California', 'State Leadership Conference for the state of California.', Image.asset('assets/images/sacramento.png')));
      list.add(Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/15,bottom:0)));
    }
    if(isRow) return new Row(children: list);
    else if(!isRow) return new Column(children : list);
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
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: MyApp.backgroundColor,
                child: ListView(
                  children: <Widget>[

                    SizedBox(
                      height: sizingInformation.myScreenSize.height/60,
                    ),

                    Container(
                      width: sizingInformation.myScreenSize.width/1.3,
                      child: SimpleRoundButton(
                        backgroundColor: MyApp.appBarColor,
                        buttonText: Text('My Events', style: TextStyle(color: MyApp.whiteNoChangeColor),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => eventScreen(
                            eventName: "Bay Section",
                            eventDescription: "I like to eat pies",
                            eventDate: "Feburary 8th, 2020",
                            eventLocation: "Westmoor High School",
                            eventState: "California",
                            eventLink: "https://www.cafbla.org/domain/70",
                            eventImage: Image.asset("assets/images/sacramento.png",fit: BoxFit.fill,),
                          )),);
                        },
                      ),
                    ),

                    SizedBox(
                      height: sizingInformation.myScreenSize.height/20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Competitive Events',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: MyApp.blackTextColor
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: sizingInformation.myScreenSize.height/30,
                    ),

                    Container(
                      height: sizingInformation.myScreenSize.height/3,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return eventCard(sizingInformation,true);
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
                            color: MyApp.blackTextColor,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: MyApp.blackTextColor,
                            width: 3,
                            style: BorderStyle.solid,
                          )
                      ),
                      child: CalendarCarousel(
                        onDayPressed: (DateTime date, List<Event> events) {
                          this.setState(() => date = DateTime.now());
                        },
                        weekendTextStyle: TextStyle(
                          color: MyApp.blackTextColor,
                        ),
                        thisMonthDayBorderColor: MyApp.blackTextColor,
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
                ),
              ),
            ),
          ],
        ),
      );
    },);}}

