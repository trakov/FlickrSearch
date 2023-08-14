import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        SDImageCache.shared.config.maxMemoryCost = 100 * 1024 * 1024
        
        return true
    }
}

