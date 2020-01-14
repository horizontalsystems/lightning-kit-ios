import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(showInfo))

        print("DID LOAD")
    }

    @objc func showInfo() {
        print("SHOW INFO:")
    }

}
