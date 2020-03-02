import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference fbla_users = Firestore.instance.collection("fbla_users");

  Future updateUserData(String fullName, int count, String chapter, String phone, bool isOfficer, List<String> events) async {
    return await fbla_users.document(uid).setData({
      'full_name': fullName,
      'count': count,
      'chapter': chapter,
      'phone': phone,
      'isOfficer': isOfficer,
      'events': events,
    });
  }

  Future addEvent(String event, String user_id) async {
    DocumentReference docRef = fbla_users.document(user_id);
    DocumentSnapshot doc = await docRef.get();
    docRef.updateData({
      'events': FieldValue.arrayUnion([event])
    });
  }

  Future removeEvent(String event, String user_id) async {
    DocumentReference docRef = fbla_users.document(user_id);
    DocumentSnapshot doc = await docRef.get();
    docRef.updateData({
    'events': FieldValue.arrayRemove([event])
    });
  }

  Future<List<String>> getSignedUpEvents(String user_id) async {
    DocumentSnapshot userSnapshot = await getUser(uid);
    var data = userSnapshot.data['events'];
    print(data);
    return data;
  }

  Future getUser(String uid) async {
    try {
      return await fbla_users.document(uid).get();
    } catch (e) {
      print(e);
    }
  }
}