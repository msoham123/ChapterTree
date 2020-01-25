import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';


class eventCard extends StatelessWidget {
  SizingInformation sizingInformation;
  eventCard(SizingInformation sizingInformation){
    this.sizingInformation=sizingInformation;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Center(child: Text('Event Details')),
                content: Container(
                  height: sizingInformation.myScreenSize.height/1.8,
                  width: sizingInformation.myScreenSize.width/1.3,
                  child: Column(
                    children: <Widget>[
                      AbsorbPointer(child: eventCard(sizingInformation)),
                      Container(
                        height: sizingInformation.myScreenSize.height/8.1,
                        child: ListView(
                          children: <Widget>[
                            Text("Fremont High School is a high school located in Sunnvale, California. Therefore, eat donuts."),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/70,bottom:0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.green,
                            child: Text("Sign Up"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            child: Text("Back"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
        );
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: sizingInformation.myScreenSize.width/1.75,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
//          Positioned(
//            bottom: 15.0,
//            child: Container(
//              height: 120.0,
//              width: 200.0,
//              decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.circular(10.0),
//              ),
//              child: Padding(
//                padding: EdgeInsets.all(10.0),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
//                      'Bay Section',
//                      style: TextStyle(
//                        fontSize: 22.0,
//                        fontWeight: FontWeight.w600,
//                        letterSpacing: 1.2,
//                      ),
//                    ),
//                    Text(
//                      "I like pies because they are good",
//                      style: TextStyle(
//                        color: Colors.grey,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
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
                    tag: Image.asset('assets/images/sacramento.png'),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        height: sizingInformation.myScreenSize.height/3.25,
                        width: sizingInformation.myScreenSize.width/1.8,
                        image: AssetImage('assets/images/sacramento.png'),
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
                          'Sacramento',
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
                              'LOLOL',
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