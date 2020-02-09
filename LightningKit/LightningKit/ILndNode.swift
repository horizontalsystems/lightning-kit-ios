import GRPC
import RxSwift

protocol ILndNode {
    var statusObservable: Observable<NodeStatus> { get }
    func getInfo() -> Single<Lnrpc_GetInfoResponse>
}
