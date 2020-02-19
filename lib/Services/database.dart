import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference fbla_users = Firestore.instance.collection("fbla_users");

  Future updateUserData(String fullName, int count, String chapter) async {
    return await fbla_users.document(uid).setData({
      'full_name': fullName,
      'count': count,
      'chapter': chapter
    });
  }
  Future getUser(String uid) async {
    try {
      return await fbla_users.document(uid).get();
    } catch (e) {
      print(e);
    }
  }
}