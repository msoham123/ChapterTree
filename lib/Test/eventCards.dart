import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app_dev/Screens/eventsScreen.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/models/eventListModel.dart';

import '../main.dart';


class eventCard extends StatelessWidget {
  String title, description, date, location, state, url;
  Image picture;
  SizingInformation sizingInformation;
  FBLAEvent thisEvent;

  eventCard(SizingInformation sizingInformation, FBLAEvent thisEvent){
    this.sizingInformation = sizingInformation;
    this.thisEvent = thisEvent;
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            eventScreen(
              eventName: thisEvent.title,
              eventDescription: thisEvent.description,
              eventDate: thisEvent.date,
              eventLocation: thisEvent.location,
              eventState: thisEvent.state,
              eventLink: thisEvent.url,
              eventImage: thisEvent.picture,
              DEST: thisEvent.coordinate,
            )));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: sizingInformation.myScreenSize.width/1.75,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: thisEvent.picture,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        height: sizingInformation.myScreenSize.height/3.25,
                        width: sizingInformation.myScreenSize.width/1.8,
                        image: thisEvent.picture.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    bottom: 10.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          thisEvent.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_upward,
                              size: 10.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              thisEvent.location,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}