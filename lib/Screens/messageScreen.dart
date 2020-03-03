import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_dev/Utils/constants.dart';
import 'package:mobile_app_dev/UI/message_bubble.dart';
import 'package:mobile_app_dev/Services/database.dart';
import '../main.dart';

FirebaseUser loggedInUser;
String name = '';
final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

class myMessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new myMessageState();
  }
}

class myMessageState extends State<myMessageScreen> {
  final messageTextController = TextEditingController();
  String messageText = "";

  PageController _pageController;
  DatabaseService ds = new DatabaseService();
  DocumentSnapshot userSnapshot;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getCurrentUser();
    _populateCurrentUser(loggedInUser);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // GET INFORMATION ON CURRENT LOGGED IN USER
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

  // POPULATE CURRENT USER INFORMATION
  void _populateCurrentUser(FirebaseUser user) async {
    final FirebaseUser user = await _auth.currentUser();
    final String userUID = user.uid.toString();
    if(user != null) {
      userSnapshot = await ds.getUser(userUID);
    }
    name = userSnapshot.data['full_name'].toString();
    print(name);
  }

  // PRINT MESSAGES STREAM
  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                    onPressed: () {
                      messageTextController.clear();
                      // messageText + loggedInUser.email
                      _firestore.collection('messages').add({
                        'sender': name,
                        'text': messageText,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // SORT THE MESSAGES BY THEIR TIMESTAMP
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        // flutter's async snapshot
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: MyApp.appBarColor,
            ),
          );
        }
        else {
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            // data = document snapshot from firebase
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];
            final currentUser = name;

            final messageWidget = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        }
      },
    );
  }
}
