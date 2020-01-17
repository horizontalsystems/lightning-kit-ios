import UIKit
import LightningKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        window?.overrideUserInterfaceStyle = .light
        window?.backgroundColor = .white
        
        if let credentials = App.shared.secureStorage.rpcCredentials {
            App.shared.kit = Kit(credentials: credentials)
            window?.rootViewController = UINavigationController(rootViewController: MainController())
        } else {
            window?.rootViewController = UINavigationController(rootViewController: GuestController())
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
