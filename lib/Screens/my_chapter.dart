import 'package:flutter/material.dart';
import 'package:mobile_app_dev/Screens/loginScreen.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_dev/Services/database.dart';
import 'package:mobile_app_dev/models/user.dart';

import '../main.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
Stream<List<User>> stream;

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
  Stream<QuerySnapshot> _data;
//  Color officerColor = Colors.lightBlueAccent;
//  Color regColor = Colors.white;
//  Color officialColor;
  bool isOfficer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getCurrentUser();
    _populateCurrentUser(loggedInUser);
    _load();
    stream = Firestore.instance
        .collection("fbla_users")
        .orderBy('count', descending: true)
        .snapshots()
        .asyncMap((QuerySnapshot snapshot) => convert(snapshot));
  }

  Future<List<User>> convert(QuerySnapshot snapshot) {
    return Future.wait(snapshot.documents.map((DocumentSnapshot docSnap) async {
      return await groupToPair(docSnap);
    }).toList());
  }

  Future<User> groupToPair(DocumentSnapshot documentSnapshot) {
    return Firestore.instance
        .collection("fbla_users")
        .where('chapter', isEqualTo: chapter)
        .orderBy('createdAt', descending: false)
        .getDocuments()
        .then((usersSnap) {

      return User.fromDoc(documentSnapshot);
    });
  }


  _load() {
    _data = _firestore
        .collection('fbla_users')
//       .where("chapter", isEqualTo: chapter)
        .orderBy('count', descending: true)
        .snapshots();
  }

  Future<void> _loadChapter() async {
    return await _populateCurrentUser(loggedInUser);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // GET INFO ON CURRENT LOGGED IN USER
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

  // POPULATE INFORMATION ON THE CURRENT LOGGED IN USER SUCH AS THEIR NAME, CHAPTER, ETC
  void _populateCurrentUser(FirebaseUser user) async {
    final FirebaseUser user = await _auth.currentUser();
    final String userUID = user.uid.toString();
    if (user != null) {
      userSnapshot = await ds.getUser(userUID);
    }
    chapter = userSnapshot.data['chapter'].toString();
    isOfficer = userSnapshot.data['isOfficer'];

    print(userSnapshot.data['chapter']);
  }


  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return FutureBuilder(
        future: _loadChapter(),
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: MyApp.backgroundColor,
              body: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                // SORT THE USERS BY THEIR ATTENDANCE COUNT (HIGHEST ON THE TOP)
                    .collection('fbla_users')
                    .where("chapter", isEqualTo: chapter)
                    .orderBy('count', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return ListView.builder(
                    itemExtent: 80.0,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data.documents[index]),
                  );
                },
              ),
            );
          }
      );
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    int initCount = document['count'];
    return Card(
      color: MyApp.botBarColor,
      child: Center(
        child: FutureBuilder(
          future: _loadChapter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                color: MyApp.botBarColor,
                child: ListTile(
                  leading: Image.asset('./assets/images/fbla.png'),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${document['full_name']}',
                          style: TextStyle(color: MyApp.blackTextColor),
                        ),
                      ),
                      Visibility(
                        visible: isOfficer,
                        child: GestureDetector(
                          onTap: () {
                            document.reference.updateData({'count': document['count'] - 1});
                            setState(() {
                              initCount--;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            height: 35.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.lightBlue,
                            ),
                            child: Icon(Icons.remove, color: Colors.white,),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isOfficer,
                        child: GestureDetector(
                          onTap: () {
                            document.reference.updateData({'count': document['count'] + 1});
                            setState(() {
                              initCount++;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            height: 35.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.blue,
                            ),
                            child: Icon(Icons.add, color: Colors.white,),
                          ),
                        ),
                      ),
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: MyApp.blueGreyColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              initCount.toString(),
                              style: TextStyle(
                                  color: MyApp.whiteTextColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      elevation: 10.0,
    );
  }
}
