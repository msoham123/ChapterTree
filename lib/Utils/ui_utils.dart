import 'package:flutter/cupertino.dart';
import 'package:mobile_app_dev/enums/device_screen_type.dart';

DeviceScreenType getDeviceScreenType(MediaQueryData mediaQuery){
  var orientation = mediaQuery.orientation;

  // Fixed Device Width (Changes with Orientation)
  double deviceWidth = 0;
  if (orientation==Orientation.landscape){
    deviceWidth = mediaQuery.size.height;
  }else if (orientation==Orientation.portrait){
    deviceWidth = mediaQuery.size.width;
  }

  // Constraints

  if (deviceWidth>950){
    return DeviceScreenType.Desktop;
  }

  if (deviceWidth>600){
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;
}