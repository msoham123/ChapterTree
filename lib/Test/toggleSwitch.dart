import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mySwitch extends StatefulWidget {
   mySwitch({@required this.switchValue, @required this.valueChanged, @required this.title});

  final bool switchValue;
  final ValueChanged valueChanged;
  final String title;

  @override
  _Switch createState() => _Switch();
}

class _Switch extends State<mySwitch> {
  bool _switchValue;

  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    return Container(
//      child: CupertinoSwitch(
//          value: _switchValue,
//          onChanged: (bool value) {
//            setState(() {
//              _switchValue = value;
//              widget.valueChanged(value);
//            });
//          }),
//    );

    return Container(
      child:  SwitchListTile(
        title: Text(widget.title),
        value: _switchValue,
        onChanged: (bool value){
          setState(() {
            _switchValue = value;
            widget.valueChanged(value);
          });
        },
        activeTrackColor: Colors.blueAccent,
        activeColor: Colors.blue,
      ),
    );
  }
}