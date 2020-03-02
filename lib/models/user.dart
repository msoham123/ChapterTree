import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String fullName;
  final int count;
  final String chapter;

  User(this.fullName, this.count, this.chapter);

  User.fromData(Map<String, dynamic> data)
      : fullName = data['fullName'],
        count = data['count'],
        chapter = data['chapter'];

  static User fromDoc(DocumentSnapshot data) {
    String fullName = data['fullName'];
    int count = data['count'];
    String chapter = data['chapter'];
    return User(fullName, count, chapter);
  }

  Map<String, dynamic> toJSON() {
    return {
      'fullName': fullName,
      'count':count,
      'chapter':chapter
    };
  }
}