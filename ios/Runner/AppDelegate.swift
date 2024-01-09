import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let schemeName = Bundle.main.infoDictionary?["SCHEME_NAME"] as? String
    switch schemeName {
        case "dev":
            GMSServices.provideAPIKey("AIzaSyBECqG4FqzBG6CHfwQuQiCpJYJUlnA-SgY")
            break
        case "prod":
            GMSServices.provideAPIKey("AIzaSyBECqG4FqzBG6CHfwQuQiCpJYJUlnA-SgY")
            break
        default:
            GMSServices.provideAPIKey("")
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
