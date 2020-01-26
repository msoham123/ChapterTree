import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_dev/UI/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/flexible_container.dart';
import 'package:mobile_app_dev/UI/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_dev/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_dev/UI/message_bubble.dart';

FirebaseUser loggedInUser;
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getCurrentUser();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                        'sender': loggedInUser.email,
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
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        // flutter's async snapshot
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
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
            final currentUser = loggedInUser.email;

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
