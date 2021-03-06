import UIKit
import LightningKit
import Logging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        LoggingSystem.bootstrap {
          var handler = StreamLogHandler.standardOutput(label: $0)
            handler.logLevel = .trace
          return handler
        }
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        window?.overrideUserInterfaceStyle = .light
        window?.backgroundColor = .white

        if let lndUrl = try? FileManager.default.walletDirectory() {
            App.shared.secureStorage.localNodeCredentials = LocalNodeCredentials(lndDirPath: lndUrl.path, password: "123456789")
            window?.rootViewController = UINavigationController(rootViewController: MainController())
            return true
        }

        if let credentials = App.shared.secureStorage.rpcCredentials {
            App.shared.kit = try? Kit.remote(rpcCredentials: credentials)
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
