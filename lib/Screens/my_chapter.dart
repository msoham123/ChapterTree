import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

class myChapterScreen extends StatefulWidget {
  @override
  _myChapterScreen createState() => _myChapterScreen();
}

class _myChapterScreen extends State<myChapterScreen> {
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

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(
          body: StreamBuilder(
              stream: _firestore.collection('members').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data.documents[index]),
                );
              }));
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: Center(
        child: GestureDetector(
          onDoubleTap: () {
            document.reference.updateData({
              'count': document['count'] + 1
            });
          },
          child: ListTile(
            leading: Image.asset('./assets/images/fbla.png'),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    document['name'],
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Color(0xffddddff),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(document['count'].toString()),
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
