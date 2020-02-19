class User {
  final String fullName;
  final int count;
  final String chapter;

  User({this.fullName, this.count, this.chapter});

  User.fromData(Map<String, dynamic> data)
      : fullName = data['fullName'],
        count = data['count'],
        chapter = data['chapter'];

  Map<String, dynamic> toJSON() {
    return {
      'fullName': fullName,
      'count':count,
      'chapter':chapter
    };
  }
}