import GRPC
import RxSwift

public class Kit {
    private let lndNode: ILndNode
    
    public var statusObservable: Observable<NodeStatus> {
        lndNode.statusObservable
    }
    
    fileprivate init(lndNode: ILndNode) {
        self.lndNode = lndNode
    }
}

public extension Kit {
    static func validateRemoteConnection(rpcCredentials: RpcCredentials) -> Single<Void> {
        do {
            let remoteLndNode = try RemoteLnd(rpcCredentials: rpcCredentials)
            
            return remoteLndNode.validateAsync()
        } catch {
            return Single.error(error)
        }
    }

    static func remote(rpcCredentials: RpcCredentials) throws -> Kit {
        let remoteLndNode = try RemoteLnd(rpcCredentials: rpcCredentials)
        remoteLndNode.scheduleStatusUpdates()
        
        return Kit(lndNode: remoteLndNode)
    }
}
