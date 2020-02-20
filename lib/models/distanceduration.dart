class DistanceDuration{
  String text;
  int value;

  DistanceDuration({this.text, this.value});

  DistanceDuration.fromMap(Map<String, dynamic> _map) {
    text = _map['text'] as String;
    value = _map['value'] as int;
  }
}