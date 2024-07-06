import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.quoter", binaryMessenger: controller.binaryMessenger)
      channel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch (call.method) {
          case "shareFile":
              let path = call.arguments as! String
              print("Path = \(path)")
              if let image = UIImage(contentsOfFile: path) {
                    
                          let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                          
                          // Exclude certain activity types if necessary
                          activityViewController.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
                          
                          // Present the view controller
                  controller.present(activityViewController, animated: true, completion: nil)
                      }
              break
          default:
              break
          }
      })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
