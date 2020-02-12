import 'package:flutter/material.dart';

const kAuthButtonDecoration = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w800,
  fontSize: 15,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

final kBottomSheetBoxDecoration = BoxDecoration(
  border: Border.all(
      color: Colors.blue,
      width: 5.0,
      style: BorderStyle.solid
  ),
  color: Colors.white60,
  borderRadius: BorderRadius.vertical(
    top:  Radius.circular(50.0),
  ),
);
