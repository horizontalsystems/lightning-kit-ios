import UIKit
import LightningKit
import SnapKit

class RemoveNodeController: UIViewController {
    private let addressTextField = UITextField()
    private let certificateTextView = UITextView()
    private let macaroonTextView = UITextView()
    private let connectButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Connect to Remote Node"

        let addressLabel = UILabel()
        let certificateLabel = UILabel()
        let macaroonLabel = UILabel()

        view.addSubview(addressLabel)
        view.addSubview(addressTextField)
        view.addSubview(certificateLabel)
        view.addSubview(certificateTextView)
        view.addSubview(macaroonLabel)
        view.addSubview(macaroonTextView)
        view.addSubview(connectButton)

        addressLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }

        addressTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }

        certificateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(addressTextField.snp.bottom).offset(20)
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

        addressLabel.text = "Address:"
        certificateLabel.text = "Certificate:"
        macaroonLabel.text = "Macaroon:"

        addressTextField.layer.cornerRadius = 4
        addressTextField.layer.borderWidth = 1
        addressTextField.layer.borderColor = UIColor.lightGray.cgColor

        connectButton.layer.cornerRadius = 12
        connectButton.layer.borderWidth = 1
        connectButton.layer.borderColor = UIColor.darkGray.cgColor

        connectButton.setTitle("Connect", for: .normal)
        connectButton.setTitleColor(.darkGray, for: .normal)
        connectButton.setTitleColor(.lightGray, for: .highlighted)
        connectButton.addTarget(self, action: #selector(onTapConnect), for: .touchUpInside)

        configure(textView: certificateTextView)
        configure(textView: macaroonTextView)

        addressTextField.text = Configuration.remoteNodeAddress
        certificateTextView.text = Configuration.remoteNodeCertificate
        macaroonTextView.text = Configuration.remoteNodeMacaroon
    }

    @objc func onTapConnect() {
        guard let address = addressTextField.text, !address.isEmpty else { return }
        guard let certificate = certificateTextView.text, !certificate.isEmpty else { return }
        guard let macaroon = macaroonTextView.text, !macaroon.isEmpty else { return }

        GuestKit.testRemoteNode(address: address, certificate: certificate, macaroon: macaroon)
    }

    private func configure(textView: UITextView) {
        textView.layer.cornerRadius = 4
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor

        textView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }

}
