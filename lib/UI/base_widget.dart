import 'package:flutter/material.dart';
import 'package:mobile_app_dev/UI/sizing_information.dart';
import 'package:mobile_app_dev/Utils/ui_utils.dart';

class BaseWidget extends StatelessWidget{
  final Widget Function(BuildContext context, SizingInformation sizingInformation) builder;
  const BaseWidget({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(
        builder : (context, boxConstraints) {

          var sizingInformation = SizingInformation(
            myOrientation: mediaQuery.orientation,
            myDeviceScreenType: getDeviceScreenType(mediaQuery),
            myScreenSize: mediaQuery.size,
            myLocalWidgetSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight)
          );
          return builder(context, sizingInformation);

        });
  }
}