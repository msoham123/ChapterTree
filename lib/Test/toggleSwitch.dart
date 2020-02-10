import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

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
        title: Center(child: Text(widget.title, style: TextStyle(color: MyApp.blackTextColor),)),
        value: _switchValue,
        
        onChanged: (bool value){
          setState(() {
            _switchValue = value;
            widget.valueChanged(value);
          });
        },
        activeTrackColor: MyApp.blueGreyColor,
        activeColor: MyApp.appBarColor,
      ),
    );
  }
}