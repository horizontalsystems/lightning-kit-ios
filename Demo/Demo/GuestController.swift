import UIKit
import SnapKit

class GuestController: UIViewController {
    private let createButton = UIButton()
    private let restoreButton = UIButton()
    private let remoteButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "LightningKit Demo App"

        view.addSubview(createButton)
        view.addSubview(restoreButton)
        view.addSubview(remoteButton)

        restoreButton.snp.makeConstraints { make in
            make.top.equalTo(createButton.snp.bottom).offset(30)
        }

        remoteButton.snp.makeConstraints { make in
            make.top.equalTo(restoreButton.snp.bottom).offset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }

        configure(button: createButton, title: "Create Wallet - Local Node", action: #selector(onTapCreate))
        configure(button: restoreButton, title: "Restore Wallet - Local Node", action: #selector(onTapRestore))
        configure(button: remoteButton, title: "Connect to Remote Node", action: #selector(onTapRemote))
    }

    @objc func onTapCreate() {
        print("Create")
    }

    @objc func onTapRestore() {
        print("Restore")
    }

    @objc func onTapRemote() {
        let controller = RemoveNodeController()
        navigationController?.pushViewController(controller, animated: true)
    }

    private func configure(button: UIButton, title: String, action: Selector) {
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor

        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: action, for: .touchUpInside)

        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

}
