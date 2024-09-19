import Flutter
import InAppPurchases
import StoreKit
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let store = IAPHelper.shared

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.quoter", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
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
            case "openUrl":
                let address = call.arguments as! String
                if let url = URL(string: address) {
                    UIApplication.shared.open(url)
                }
            case "removeAdsForever":
                self.store.buyProduct("com.nanashi.quoter1111.all") { success in
                    print("AppDelegate removeAdsForever", success)
                    result(success)
                }
            case "removeAds1Month":
                self.store.buyProduct("com.nanashi.quoter1111.1month") { success in
                    print("AppDelegate removeAds1Month", success)
                    result(success)
                }
            case "removeAds2Months":
                self.store.buyProduct("com.nanashi.quoter1111.2month") { success in
                    print("AppDelegate removeAds2Months", success)
                    result(success)
                }
            case "removeAds6Months":
                self.store.buyProduct("com.nanashi.quoter1111.6month") { success in
                    print("AppDelegate removeAds6Months", success)
                    result(success)
                }
            case "restoreProduct":
                self.store.getPurchasedProduct { isPurchased in
                    print("AppDelegate restoreProduct", isPurchased)
                    result(isPurchased)
                }
            default:
                break
            }
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    @objc func didGetIsEnabled(isEnabled: Bool) {
        print("isEnabled", isEnabled)
    }

    @objc func deliverPurchaseNotification(item: String) {
        print("buy success", item)
    }

    @objc func didGetProd(notification: Notification) {
        DispatchQueue.main.async {
            let data = notification.object as! [SKProduct]
            print(data)
        }
    }
}
