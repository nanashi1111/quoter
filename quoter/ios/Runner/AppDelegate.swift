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
            case "showPrivacy":
                let address = call.arguments as! String
                if let url = URL(string: address) {
                    UIApplication.shared.open(url)
                }
            case "removeAdsForever":
                self.store.buyProduct("com.nanashi1111.quoter.all") { success in
                    result(success)
                }
            case "removeAds1Month":
                self.store.buyProduct("com.nanashi1111.quoter.sub.1month") { success in
                    result(success)
                }
            case "removeAds2Months":
                self.store.buyProduct("com.nanashi1111.quoter.sub.2month") { success in
                    result(success)
                }
            case "removeAds6Months":
                self.store.buyProduct("com.nanashi1111.quoter.sub.6month") { success in
                    result(success)
                }
            case "getPurchasedProduct":
                if let prod = self.store.getPurchasedProduct().first {
                    result(prod)
                } else {
                    result("")
                }
            case "restoreProduct":
                self.store.restorePurchases()
                let prods = self.store.getPurchasedProduct()
                result(prods.count > 0)
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
