import UIKit
import Flutter
import InAppPurchases
import StoreKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let store = IAPHelper.shared
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      NotificationCenter.default.addObserver(self, selector: #selector(didGetProd(notification:)), name: .didGetProduct, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(didGetIsEnabled), name: .isEnabled, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(deliverPurchaseNotification), name: .complete, object: nil)
      
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
          case "showPrivacy":
              let address = call.arguments as! String
              if let url = URL(string: address) {
                      UIApplication.shared.open(url)
                  }
              break
          case "removeAdsForever":
              guard let product = self.store.products.first(where: { $0.productIdentifier == "com.nanashi1111.quoter.all" }) else { return }
              self.store.buyProduct(product)
              break
          case "removeAds1Month":
              guard let product = self.store.products.first(where: { $0.productIdentifier == "com.nanashi1111.quoter.sub.1month" }) else { return }
              self.store.buyProduct(product)
              break
          case "removeAds2Months":
              guard let product = self.store.products.first(where: { $0.productIdentifier == "com.nanashi1111.quoter.sub.2month" }) else { return }
              self.store.buyProduct(product)
              break
          case "removeAds6Months":
              guard let product = self.store.products.first(where: { $0.productIdentifier == "com.nanashi1111.quoter.sub.6month" }) else { return }
              self.store.buyProduct(product)
              break
          default:
              break
          }
      })
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
