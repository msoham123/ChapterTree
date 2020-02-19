import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_dev/Services/database.dart';

import '../main.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

class myChapterScreen extends StatefulWidget {
  @override
  _myChapterScreen createState() => _myChapterScreen();
}

class _myChapterScreen extends State<myChapterScreen> {
  PageController _pageController;
  FirebaseUser loggedInUser;
  DocumentSnapshot userSnapshot;
  DatabaseService ds = new DatabaseService();
  String chapter = '';

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


  void _populateCurrentUser(FirebaseUser user) async {
    final FirebaseUser user = await _auth.currentUser();
    final String userUID = user.uid.toString();
    if(user != null) {
      userSnapshot = await ds.getUser(userUID);
    }
    chapter = userSnapshot.data['chapter'].toString();
    print(userSnapshot.data['chapter']);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(
        backgroundColor: MyApp.backgroundColor,
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('fbla_users')
//             .where("chapter", isEqualTo: chapter)
              .orderBy('count', descending: true)
              .snapshots(includeMetadataChanges: true),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: const Text('Loading...'));
            return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          },
        ),
      );
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
      return Card(
        color: MyApp.botBarColor,
        child: Center(
          child: GestureDetector(
            onDoubleTap: () {
              document.reference.updateData({'count': document['count'] + 1});
            },
            child: ListTile(
              leading: Image.asset('./assets/images/fbla.png'),
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      document['full_name'],
                      style: TextStyle(color: MyApp.blackTextColor),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: MyApp.blueGreyColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        document['count'].toString(),
                        style: TextStyle(
                          color: MyApp.whiteTextColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        elevation: 10.0,
      );
    }
}
