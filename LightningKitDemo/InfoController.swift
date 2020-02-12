import UIKit
import SnapKit
import RxSwift
import LightningKit

class InfoController: UIViewController {

    private let syncedToChainLabel = UILabel()
    private var disposeBag: DisposeBag? = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Node Info"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        view.addSubview(syncedToChainLabel)
        
        syncedToChainLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }

        if let kit = App.shared.kit {
            createSubscriptions(kit: kit)
        } else if let credentials = App.shared.secureStorage.localNodeCredentials {
            Kit.createLocal(credentials: credentials)
                .subscribe { words in
                    print("wallet created: \(words)")
                    if let kit = Kit.lightningKitLocalLnd {
                        self.createSubscriptions(kit: kit)
                    }
                }
                .disposed(by: disposeBag!)
        }
    }
    
    func createSubscriptions(kit: Kit) {
        kit.statusObservable
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] status in
                self?.syncedToChainLabel.text = "Synced to Chain: \(status)"
            })
            .disposed(by: disposeBag!)
        
        kit.invoicesObservable
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { invoice in
                print(invoice)
            })
            .disposed(by: disposeBag!)
    }

    @objc func logout() {
        App.shared.secureStorage.rpcCredentials = nil
        App.shared.kit = nil
        disposeBag = nil

        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = UINavigationController(rootViewController: RemoteNodeController())
            })
        }
    }

}
