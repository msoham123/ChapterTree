import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/cards.dart';
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

  final _nameControllerB = TextEditingController();
  final _subjectControllerB = TextEditingController();
  final _messageControllerB = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Completer<WebViewController> _controller = Completer<WebViewController>();

//  String name = "", subject = "", message = "";

  Future<void> submitMessage() async {
    String attachment;
    bool isHTML = false;
    List<String> recepientsList = ['chaptertreefbla@gmail.com'];
    List<String> ccList = ['msoham123@gmail.com', 'aryanvichare10@gmail.com'];

    // COMPOSE AN EMAIL OBJECT BASED ON USER INPUT
    final Email email = Email(
      body: _messageController.text,
      subject: _subjectController.text,
      recipients: recepientsList,
      cc: ccList,
      attachmentPath: attachment,
      isHTML: false,
    );

    String platformResponse;

    // ERROR HANDLING FOR SENDING THE EMAIL
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
      print(platformResponse);
    }

    if (!mounted) return;
  }

  // LAUNCH GMAIL APP
  Future<void> customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Error. Could not launch $command');
    }
  }

  void _launch(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
                    height: sizingInformation.myScreenSize.height / 25,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        showBottomSheet(
                            backgroundColor: MyApp.backgroundColor,
                            context: context,
                            builder: (context) => Container(
                                  height:
                                      sizingInformation.myScreenSize.height /
                                          1.3,
                                  decoration: kBottomSheetBoxDecoration,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                          height: sizingInformation
                                                  .myScreenSize.height /
                                              45),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: sizingInformation
                                                          .myScreenSize.width /
                                                      25,
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 0)),
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.blue,
                                              ),
                                              child: IconButton(
                                                icon: Icon(Icons.arrow_back),
                                                iconSize: 30,
                                                color: Colors.white,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: sizingInformation
                                                      .myScreenSize.width /
                                                  20),
                                          Text(
                                            'Ask A Question',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                          SizedBox(
                                              width: sizingInformation
                                                      .myScreenSize.width /
                                                  20),
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.blue),
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: sizingInformation
                                                          .myScreenSize.height /
                                                      60,
                                                  horizontal: sizingInformation
                                                          .myScreenSize.width /
                                                      10),
                                              child: Builder(
                                                builder: (context) => Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      TextFormField(
                                                        controller:
                                                            _nameController,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Full Name',
                                                          icon: Icon(Icons
                                                              .account_box),
                                                        ),
                                                      ), // Name
                                                      TextFormField(
                                                        controller:
                                                            _subjectController,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Subject',
                                                          icon: Icon(
                                                              Icons.bookmark),
                                                        ),
                                                      ), // Subject
                                                      TextFormField(
                                                        controller:
                                                            _messageController,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        maxLines: 10,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Message',
                                                          icon: Icon(Icons
                                                              .speaker_notes),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                  ),
                                                  child: Text('Send'),
                                                  color: Colors.red,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    launch(
                                                        'mailto:aryanvichare10@gmail.com?subject=${_subjectController.text}&body=${_messageController.text}');
                                                  },
                                                ),
                                              ],
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0,
                                                    right: 0,
                                                    top: sizingInformation
                                                            .myScreenSize
                                                            .height /
                                                        25,
                                                    bottom: 0)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                      child: Center(
                        child: CardWidget(sizingInformation, 'Ask a Question',
                            '', Icon(Icons.send)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizingInformation.myScreenSize.height / 25,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Completer<WebViewController> _controller =
                            Completer<WebViewController>();
                        showBottomSheet(
                            context: context,
                            backgroundColor: MyApp.backgroundColor,
                            builder: (context) => Container(
                                  height:
                                      sizingInformation.myScreenSize.height /
                                          1.3,
                                  decoration: kBottomSheetBoxDecoration,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: sizingInformation
                                                      .myScreenSize.height /
                                                  45,
                                              bottom: 0)),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: sizingInformation
                                                          .myScreenSize.width /
                                                      25,
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 0)),
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.blueAccent),
                                              child: IconButton(
                                                icon: Icon(Icons.arrow_back),
                                                iconSize: 30,
                                                color: Colors.white,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: sizingInformation
                                                      .myScreenSize.width /
                                                  8),
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
                                      SizedBox(
                                          height: sizingInformation
                                                  .myScreenSize.height /
                                              25),
                                      Expanded(
                                        child: Scaffold(
                                          body: WebView(
                                            initialUrl:
                                                "https://www.fbla-pbl.org/fbla/",
                                            gestureNavigationEnabled: true,
                                            gestureRecognizers: <
                                                Factory<
                                                    OneSequenceGestureRecognizer>>{
                                              Factory<
                                                  VerticalDragGestureRecognizer>(
                                                () =>
                                                    VerticalDragGestureRecognizer()
                                                      ..onUpdate = (_) {},
                                              ),
                                            },
                                            onWebViewCreated: (WebViewController
                                                webViewController) {
                                              _controller
                                                  .complete(webViewController);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                      child: Center(
                        child: CardWidget(sizingInformation, 'About FBLA', '',
                            Icon(Icons.send)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizingInformation.myScreenSize.height / 25,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        _launch("https://forms.gle/qccYGBv24X1A3MXk6");
//                        showBottomSheet(
//                            context: context,
//                            backgroundColor: MyApp.backgroundColor,
//                            builder: (context) => Container(
//                                  height:
//                                      sizingInformation.myScreenSize.height /
//                                          1.3,
//                                  decoration: kBottomSheetBoxDecoration,
//                                  child: Column(
//                                    children: <Widget>[
//                                      Padding(
//                                          padding: EdgeInsets.only(
//                                              left: 0,
//                                              right: 0,
//                                              top: sizingInformation
//                                                      .myScreenSize.height /
//                                                  45,
//                                              bottom: 0)),
//                                      Row(
//                                        children: <Widget>[
//                                          Padding(
//                                              padding: EdgeInsets.only(
//                                                  left: sizingInformation
//                                                          .myScreenSize.width /
//                                                      25,
//                                                  right: 0,
//                                                  top: 0,
//                                                  bottom: 0)),
//                                          Flexible(
//                                            child: Container(
//                                              decoration: BoxDecoration(
//                                                  borderRadius:
//                                                      BorderRadius.circular(
//                                                          100),
//                                                  color: Colors.blueAccent),
//                                              child: IconButton(
//                                                icon: Icon(Icons.arrow_back),
//                                                iconSize: 30,
//                                                color: Colors.white,
//                                                onPressed: () {
//                                                  Navigator.pop(context);
//                                                },
//                                              ),
//                                            ),
//                                          ),
//                                          SizedBox(
//                                              width: sizingInformation
//                                                      .myScreenSize.width /
//                                                  7),
//                                          Text(
//                                            'Join FBLA',
//                                            style: TextStyle(
//                                              fontSize: 30,
//                                              fontWeight: FontWeight.w900,
//                                              color: Colors.blueAccent,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      SizedBox(
//                                          height: sizingInformation
//                                                  .myScreenSize.height /
//                                              25),
//                                      Expanded(
//                                        child: Scaffold(
//                                          body: WebView(
//                                            javascriptMode: JavascriptMode.unrestricted,
//                                            initialUrl:
//                                                "https://docs.google.com/forms/d/e/1FAIpQLScJpEz7YvMfpFbPPqEr7EE9Jg0zmYBjzOwkCp-7qZR2UeT63Q/viewform?embedded=true",
//                                            gestureNavigationEnabled: true,
//                                            gestureRecognizers: <
//                                                Factory<
//                                                    OneSequenceGestureRecognizer>>{
//                                              Factory<
//                                                  VerticalDragGestureRecognizer>(
//                                                () =>
//                                                    VerticalDragGestureRecognizer()
//                                                      ..onUpdate = (_) {},
//                                              ),
//                                            },
//                                            onWebViewCreated: (WebViewController
//                                                webViewController) {
//                                              _controller
//                                                  .complete(webViewController);
//                                            },
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ));
                      },
                      child: Center(
                        child: CardWidget(sizingInformation, 'Join FBLA', '',
                            Icon(Icons.send)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizingInformation.myScreenSize.height / 25,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          backgroundColor: MyApp.whiteTextColor,
                          builder: (context) => Container(
                            height: sizingInformation.myScreenSize.height / 1.3,
                            decoration: kBottomSheetBoxDecoration,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                        top: sizingInformation
                                                .myScreenSize.height /
                                            45,
                                        bottom: 0)),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: sizingInformation
                                                    .myScreenSize.width /
                                                25,
                                            right: 0,
                                            top: 0,
                                            bottom: 0)),
                                    Flexible(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.blueAccent),
                                        child: IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          iconSize: 30,
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: sizingInformation
                                                .myScreenSize.width /
                                            4),
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
                                SizedBox(
                                    height:
                                        sizingInformation.myScreenSize.height /
                                            25),
                                Expanded(
                                  child: ListView(children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              'What is this app for?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: sizingInformation
                                                                .myScreenSize
                                                                .width /
                                                            20),
                                                    child: Text(
                                                      'ChapterTree was developed in order to allow FBLA members to manage their FBLA events and chapters.',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                          Center(
                                            child: Text(
                                              'What if I encounter a bug?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: sizingInformation
                                                                .myScreenSize
                                                                .width /
                                                            20),
                                                    child: Text(
                                                      'Please use the Report a Bug button on the questions tab to email us with any bug reports.',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                          Center(
                                            child: Text(
                                              'What can I ask the chatbot?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: sizingInformation
                                                                .myScreenSize
                                                                .width /
                                                            20),
                                                    child: Text(
                                                      'You can ask the chatbot about events, how to prepare, what is FBLA, etc. If you\'d like something added please email us through the Contact Us button.',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                          Center(
                                            child: Text(
                                              'Can I get this app on both IOS and Android?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: sizingInformation
                                                                .myScreenSize
                                                                .width /
                                                            20),
                                                    child: Text(
                                                      'You can, but it will require Xcode and Podfile knowledge to build on IOS. The App has been tested on both Android and IOS and is fully functional on both platforms.',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                          Center(
                                            child: Text(
                                              'What is the purpose of the messages tab?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: sizingInformation
                                                                .myScreenSize
                                                                .width /
                                                            20),
                                                    child: Text(
                                                      'To communicate and socialize with other FBLA members. We believe that a core aspect of FBLA is the relationships and connections you make along the way.',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: sizingInformation
                                                    .myScreenSize.height /
                                                30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: CardWidget(
                            sizingInformation, 'FAQ', '', Icon(Icons.send)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizingInformation.myScreenSize.height / 25,
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
                                      SizedBox(width: sizingInformation.myScreenSize.width/10),
                                      Text(
                                        'Report a bug',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
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
                                                    controller: _nameControllerB,
                                                    keyboardType: TextInputType.emailAddress,
                                                    decoration: InputDecoration(
                                                      labelText: 'Full Name',
                                                      icon: Icon(Icons.account_box),
                                                    ),
                                                  ), // Name
                                                  TextFormField(
                                                    controller: _subjectControllerB,
                                                    keyboardType: TextInputType.emailAddress,
                                                    decoration: InputDecoration(
                                                      labelText: 'Bug Subject',
                                                      icon: Icon(Icons.bookmark),
                                                    ),
                                                  ), // Subject
                                                  TextFormField(
                                                    controller: _messageControllerB,
                                                    keyboardType: TextInputType.emailAddress,
                                                    maxLines: 10,
                                                    decoration: InputDecoration(
                                                      labelText: 'Describe the Bug',
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
                        child: CardWidget(sizingInformation,'Report a Bug','', Icon(Icons.send)),
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
