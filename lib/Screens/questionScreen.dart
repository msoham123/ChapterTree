import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_app_dev/Screens/chatbot.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/cards.dart';
import 'package:mobile_app_dev/UI/simple_round_icon_button.dart';
import 'package:mobile_app_dev/UI/simple_round_only_icon_button.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mobile_app_dev/Utils/constants.dart';

import '../main.dart';

class myQuestionScreen extends StatefulWidget {
  @override
  _myQuestionScreenState createState() => _myQuestionScreenState();
}

class _myQuestionScreenState extends State<myQuestionScreen> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffEC9F05), Color(0xffFF4E00)],
  ).createShader(
    Rect.fromLTWH(0.0, 0.0, 200.0, 90.0),
  );

  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Completer<WebViewController> _controller = Completer<WebViewController>();

//  String name = "", subject = "", message = "";



  Future<void> submitMessage() async {
    String attachment;
    bool isHTML = false;
    List<String> recepientsList = ['chaptertreefbla@gmail.com'];
    List<String> ccList = ['msoham123@gmail.com','aryanvichare10@gmail.com'];

    final Email email = Email(
      body: _messageController.text,
      subject: _subjectController.text,
      recipients: recepientsList,
      cc: ccList,
      attachmentPath: attachment,
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
      print(platformResponse);
    }

    if (!mounted) return;
  }

  Future<void> customLaunch(command) async {
    if(await canLaunch(command)) {
      await launch(command);
    } else {
      print('Error. Could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(
        backgroundColor: MyApp.backgroundColor,
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[

                  SizedBox(
                    height: sizingInformation.myScreenSize.height/25,
                  ),

                  Container(
                    child: GestureDetector(
                      onTap: (){
                        showBottomSheet(
                            backgroundColor: MyApp.backgroundColor,
                            context: context,
                            builder: (context) => Container(
                              height: sizingInformation.myScreenSize.height/1.3,
                              decoration: kBottomSheetBoxDecoration,

                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: sizingInformation.myScreenSize.height/45),
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/25,right: 0,top: 0,bottom:0)),
                                      Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.blue,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            iconSize: 30,
                                            color: Colors.white,
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: sizingInformation.myScreenSize.width/20),
                                      Text(
                                        'Ask A Question',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      SizedBox(width: sizingInformation.myScreenSize.width/20),
                                      Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.blue
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: sizingInformation.myScreenSize.height/60, horizontal: sizingInformation.myScreenSize.width/10),
                                          child: Builder(
                                            builder: (context) => Form(
                                              key: _formKey,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  TextFormField(
                                                    controller: _nameController,
                                                    keyboardType: TextInputType.emailAddress,
                                                    decoration: InputDecoration(
                                                      labelText: 'Full Name',
                                                      icon: Icon(Icons.account_box),
                                                    ),
                                                  ), // Name
                                                  TextFormField(
                                                    controller: _subjectController,
                                                    keyboardType: TextInputType.emailAddress,
                                                    decoration: InputDecoration(
                                                      labelText: 'Subject',
                                                      icon: Icon(Icons.bookmark),
                                                    ),
                                                  ), // Subject
                                                  TextFormField(
                                                    controller: _messageController,
                                                    keyboardType: TextInputType.emailAddress,
                                                    maxLines: 10,
                                                    decoration: InputDecoration(
                                                      labelText: 'Message',
                                                      icon: Icon(Icons.speaker_notes),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18),
                                              ),
                                              child : Text('Send'),
                                              color : Colors.red,
                                              textColor : Colors.white,
                                              onPressed: () {
                                                launch(
                                                    'mailto:aryanvichare10@gmail.com?subject=${_subjectController.text}&body=${_messageController.text}'
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/25,bottom:0)),
                                      ],
                                    ),
                                  ),

                                ],
                              ) ,
                            ));
                      },
                      child: Center(
                          child: CardWidget(sizingInformation,'Ask a Question','', Icon(Icons.send)),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: sizingInformation.myScreenSize.height/25,
                  ),

                  Container(
                    child: GestureDetector(
                      onTap: (){
                        Completer<WebViewController> _controller = Completer<WebViewController>();
                        showBottomSheet(context: context,
                            backgroundColor: MyApp.backgroundColor,
                            builder: (context) => Container(
                              height: sizingInformation.myScreenSize.height/1.3,
                              decoration: kBottomSheetBoxDecoration,
                              child: Column(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/45,bottom:0)),
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/25,right: 0,top: 0,bottom:0)),
                                      Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.blueAccent
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            iconSize: 30,
                                            color: Colors.white,
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: sizingInformation.myScreenSize.width/8),
                                      Text(
                                        'About FBLA',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: sizingInformation.myScreenSize.height/25),

                                  Expanded(
                                    child: Scaffold(
                                      body: WebView(
                                        initialUrl: "https://www.fbla-pbl.org/fbla/",
                                        gestureNavigationEnabled: true,
                                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                                          Factory<VerticalDragGestureRecognizer>(
                                                () => VerticalDragGestureRecognizer()..onUpdate = (_) {},
                                          ),
                                        },
                                        onWebViewCreated: (WebViewController webViewController) {
                                          _controller.complete(webViewController);
                                        },
                                      ),
                                    ),
                                  ),

                                ],
                              ) ,
                            ));
                      },
                      child: Center(
                        child: CardWidget(sizingInformation,'About FBLA','', Icon(Icons.send)),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: sizingInformation.myScreenSize.height/25,
                  ),

                  Container(
                    child: GestureDetector(
                      onTap: (){
                        showBottomSheet(context: context,
                            backgroundColor: MyApp.backgroundColor,
                            builder: (context) => Container(
                              height: sizingInformation.myScreenSize.height/1.3,
                              decoration: kBottomSheetBoxDecoration,

                              child: Column(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/45,bottom:0)),
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/25,right: 0,top: 0,bottom:0)),
                                      Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.blueAccent
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            iconSize: 30,
                                            color: Colors.white,
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: sizingInformation.myScreenSize.width/7),
                                      Text(
                                        'Join FBLA',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: sizingInformation.myScreenSize.height/25),

                                  Expanded(
                                    child: Scaffold(
                                      body: WebView(
                                        initialUrl: "https://www.fbla-pbl.org/about/regions/",
                                        gestureNavigationEnabled: true,
                                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                                          Factory<VerticalDragGestureRecognizer>(
                                                () => VerticalDragGestureRecognizer()..onUpdate = (_) {},
                                          ),
                                        },
                                        onWebViewCreated: (WebViewController webViewController) {
                                          _controller.complete(webViewController);
                                        },
                                      ),
                                    ),
                                  ),

                                ],
                              ) ,
                            ));
                      },
                      child: Center(
                        child: CardWidget(sizingInformation,'Join FBLA','', Icon(Icons.send)),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: sizingInformation.myScreenSize.height/25,
                  ),

                  Container(
                    child: GestureDetector(
                      onTap: (){
                        showBottomSheet(context: context,
                            backgroundColor: MyApp.whiteTextColor,
                            builder: (context) => Container(
                              height: sizingInformation.myScreenSize.height/1.3,
                              decoration: kBottomSheetBoxDecoration,

                              child: Column(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(left: 0,right: 0,top: sizingInformation.myScreenSize.height/45,bottom:0)),
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.only(left: sizingInformation.myScreenSize.width/25,right: 0,top: 0,bottom:0)),
                                      Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.blueAccent
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            iconSize: 30,
                                            color: Colors.white,
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: sizingInformation.myScreenSize.width/4),
                                      Text(
                                        'FAQ',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: sizingInformation.myScreenSize.height/25),

                                  Expanded(
                                    child: ListView(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Text('What'),
                                              ],
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),

                                ],
                              ) ,
                            ));
                      },
                      child: Center(
                        child: CardWidget(sizingInformation,'FAQ','', Icon(Icons.send)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}



