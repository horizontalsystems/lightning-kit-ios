import UIKit
import LightningKit
import SnapKit

class RemoveNodeController: UIViewController {
    private let hostTextField = UITextField()
    private let portTextField = UITextField()
    private let certificateTextView = UITextView()
    private let macaroonTextView = UITextView()
    private let connectButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Connect to Remote Node"

        let hostLabel = UILabel()
        let portLabel = UILabel()
        let certificateLabel = UILabel()
        let macaroonLabel = UILabel()

        view.addSubview(hostLabel)
        view.addSubview(hostTextField)
        view.addSubview(portLabel)
        view.addSubview(portTextField)
        view.addSubview(certificateLabel)
        view.addSubview(certificateTextView)
        view.addSubview(macaroonLabel)
        view.addSubview(macaroonTextView)
        view.addSubview(connectButton)

        hostLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }

        hostTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(hostLabel.snp.bottom).offset(10)
        }

        portLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(hostTextField.snp.bottom).offset(20)
        }

        portTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(portLabel.snp.bottom).offset(10)
        }

        certificateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(portTextField.snp.bottom).offset(20)
        }

        certificateTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(certificateLabel.snp.bottom).offset(10)
        }

        macaroonLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(certificateTextView.snp.bottom).offset(20)
        }

        macaroonTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(macaroonLabel.snp.bottom).offset(10)
        }

        connectButton.snp.makeConstraints { make in
            make.top.equalTo(macaroonTextView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        hostLabel.text = "HOST:"
        portLabel.text = "PORT:"
        certificateLabel.text = "CERTIFICATE:"
        macaroonLabel.text = "MACAROON:"

        connectButton.layer.cornerRadius = 12
        connectButton.layer.borderWidth = 1
        connectButton.layer.borderColor = UIColor.darkGray.cgColor

        connectButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        connectButton.setTitle("Connect", for: .normal)
        connectButton.setTitleColor(.darkGray, for: .normal)
        connectButton.setTitleColor(.lightGray, for: .highlighted)
        connectButton.addTarget(self, action: #selector(onTapConnect), for: .touchUpInside)

        configure(textField: hostTextField)
        configure(textField: portTextField)
        configure(textView: certificateTextView)
        configure(textView: macaroonTextView)

        configure(label: hostLabel)
        configure(label: portLabel)
        configure(label: certificateLabel)
        configure(label: macaroonLabel)

        hostTextField.text = Configuration.defaultRpcCredentials.host
        portTextField.text = String(Configuration.defaultRpcCredentials.port)
        certificateTextView.text = Configuration.defaultRpcCredentials.certificate
        macaroonTextView.text = Configuration.defaultRpcCredentials.macaroon
    }

    @objc func onTapConnect() {
        guard let host = hostTextField.text, !host.isEmpty else { return }
        guard let portString = portTextField.text, let port = Int(portString) else { return }
        guard let certificate = certificateTextView.text, !certificate.isEmpty else { return }
        guard let macaroon = macaroonTextView.text, !macaroon.isEmpty else { return }

        let credentials = RpcCredentials(host: host, port: port, certificate: certificate, macaroon: macaroon)

        let kit = Kit(credentials: credentials)
        if kit.state == .syncing || kit.state == .running {
            App.shared.secureStorage.rpcCredentials = credentials
            App.shared.kit = kit

            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    window.rootViewController = UINavigationController(rootViewController: MainController())
                })
            }
        } else {
            let alert = UIAlertController(title: "Wrong credentials", message: "State: \(kit.state)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }

    private func configure(textField: UITextField) {
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor

        textField.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }

    private func configure(textView: UITextView) {
        textView.layer.cornerRadius = 4
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor

        textView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }

    private func configure(label: UILabel) {
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .medium)
    }

}
