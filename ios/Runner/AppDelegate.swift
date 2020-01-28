import UIKit
import Flutter
#import "GoogleMaps/GoogleMaps.h"


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    [GMSServices provideAPIKey: @"AIzaSyCGM1AHImb50nOWd-JWxxV5d-gfxRKUJjk"];
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
