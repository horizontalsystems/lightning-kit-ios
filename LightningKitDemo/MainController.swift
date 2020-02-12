import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let infoController = UINavigationController(rootViewController: InfoController())
        infoController.tabBarItem.title = "Info"
        infoController.tabBarItem.image = UIImage(systemName: "info.circle")

        let channelsController = UINavigationController(rootViewController: ChannelsController())
        channelsController.tabBarItem.title = "Channels"
        channelsController.tabBarItem.image = UIImage(systemName: "arrow.up.left.and.arrow.down.right")

        viewControllers = [infoController, channelsController]
    }

}
