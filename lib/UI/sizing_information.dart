import 'package:flutter/material.dart';
import 'package:mobile_app_dev/enums/device_screen_type.dart';

class SizingInformation{
  final Orientation myOrientation;
  final DeviceScreenType myDeviceScreenType;
  final Size myScreenSize;
  final Size myLocalWidgetSize;

  SizingInformation({
    this.myOrientation,
    this.myDeviceScreenType,
    this.myScreenSize,
    this.myLocalWidgetSize
});

  @override
  String toString() {
    return 'Orientation : $myOrientation \nDeviceScreenType : $myDeviceScreenType \nSize : $myScreenSize';
  }




}