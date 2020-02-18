import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';

import '../main.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

class myChatBotScreen extends StatefulWidget {
  myChatBotScreen({Key key, this.title}) : super(key: key);

  final String title;

  State<StatefulWidget> createState() => myChatBotState();
}

class myChatBotState extends State<myChatBotScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController =  TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _messages.add(
      ChatMessage(
        text: "Hi " + loggedInUser.email + ", how can I assist you today?",
        name: "FBLA Bot",
        type: false
      )
    );
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

  Widget _buildTextComposer() {
    return BaseWidget(builder: (context, sizingInformation) {
      return IconTheme(
          data:  IconThemeData(color: MyApp.blackTextColor),
          child:  Container(
            color: MyApp.backgroundColor,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
            child:  Row(
              children: <Widget>[
                 Flexible(
                  child:  TextField(
                    style: TextStyle(color: MyApp.blackTextColor),
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration:  InputDecoration.collapsed(
                      hintText: "Send a message",
                      hintStyle: TextStyle(color: MyApp.blackTextColor)
                    ),
                  ),
                ),
                 Container(
                  margin:  EdgeInsets.symmetric(horizontal: 4.0),
                  child:  IconButton(
                      icon:  Icon(Icons.send),
                      onPressed: () => _handleSubmitted(_textController.text)),
                ),
              ],
            ),
          ),

        );
    }
    );
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/fbla_bot_creds.json")
        .build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message =  ChatMessage(
      text: response.getMessage() ??
           CardDialogflow(response.getListMessage()[0]).title,
      name: "FBLA Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message =  ChatMessage(
      text: text,
      name: loggedInUser.email,
      type: true,
    );
    setState(() {
      if (message != null) {
        _messages.insert(0, message);
      }
    });
    print("test = " + text);
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.backgroundColor,
      appBar:  AppBar(
        iconTheme: IconThemeData(color: MyApp.blackTextColor),
        centerTitle: true,
        title:  Text("FBLA Chatbot", style: TextStyle(color: MyApp.blackTextColor)),
        backgroundColor: MyApp.appBarColor,
      ),
      body:  Column(children: <Widget>[
         Flexible(
          child:  ListView.builder(
            padding:  EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
         Divider(height: 1.0),
         Container(
           decoration:  BoxDecoration(color: MyApp.backgroundColor,
           ),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
       Container(
        margin: const EdgeInsets.only(right: 16.0),
        child:  CircleAvatar(child:  Text('B', style: TextStyle(color: MyApp.blackTextColor))),
      ),
       Expanded(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Text(this.name,
                style:  TextStyle(fontWeight: FontWeight.bold, color: MyApp.blackTextColor)),
             Container(
              margin: const EdgeInsets.only(top: 5.0),
              child:  Text(text, style: TextStyle(color: MyApp.blackTextColor),),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
       Expanded(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
             Text(this.name, style: TextStyle(color: MyApp.blackTextColor)),
             Container(
              margin: const EdgeInsets.only(top: 5.0),
              child:  Text(text, style: TextStyle(color: MyApp.blackTextColor)),
            ),
          ],
        ),
      ),
       Container(
        margin: const EdgeInsets.only(left: 16.0),
        child:  CircleAvatar(
            child:  Text(
          this.name[0],
          style:  TextStyle(fontWeight: FontWeight.bold, color: MyApp.blackTextColor),
        )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
