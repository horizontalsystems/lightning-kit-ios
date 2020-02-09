import GRPC
import NIO
import NIOSSL
import NIOHPACK
import Logging
import RxSwift

class RemoteLnd: ILndNode {
    private let connection: LndNioConnection
    private let disposeBag = DisposeBag()
    
    private let statusSubject = PublishSubject<NodeStatus>()
    var statusObservable: Observable<NodeStatus> { statusSubject.asObservable() }
    private(set) var status: NodeStatus = .connecting {
        didSet {
            if status != oldValue {
                statusSubject.onNext(status)
            }
        }
    }

    init(rpcCredentials: RpcCredentials) throws {
        connection = try LndNioConnection(rpcCredentials: rpcCredentials)
    }
    
    func scheduleStatusUpdates() {
        Observable<Int>.interval(.seconds(3
            ), scheduler: SerialDispatchQueueScheduler(qos: .background))
            .flatMap { [weak self] _ -> Observable<NodeStatus> in
                guard let node = self else {
                    return .empty()
                }
                
                return node.fetchStatus().asObservable()
            }
            .subscribe(onNext: { [weak self] in self?.status = $0 })
            .disposed(by: disposeBag)
    }
    
    func getInfo() -> Single<Lnrpc_GetInfoResponse> {
        connection.requestLightningService(.unary) {
            let request = Lnrpc_GetInfoRequest()
            return $0.getInfo(request).response
        }
    }

    func validateAsync() -> Single<Void> {
        return fetchStatus()
            .flatMap {
                if case let .error(error) = $0 {
                    return Single.error(error)
                } else {
                    return Single.just(Void())
                }
            }
    }
    
    private func fetchStatus() -> Single<NodeStatus> {
        return getInfo()
            .map { $0.syncedToGraph ? .running : .syncing }
            .catchError { error in
                var status: NodeStatus

                if let grpcStatusError = error as? GRPCStatus {
                            if grpcStatusError.code == .unimplemented {
                                status = .locked
                            } else if grpcStatusError.code == .unavailable && self.status == .locked {
                                status = .unlocking
                            } else {
                                status = .error(error: grpcStatusError)
                            }
                } else {
                    status = .error(error: error)
                }

                return Single.just(status)
            }
    }
}
