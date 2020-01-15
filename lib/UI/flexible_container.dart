import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/base_widget.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/Utils/ui_utils.dart';

class flexContainer extends StatelessWidget{
  Widget myChild;
  flexContainer({
    this.myChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseWidget(builder: (context, sizingInfo) => myChild,),
    );
  }
}