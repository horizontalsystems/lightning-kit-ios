import GRPC
import NIO
import NIOSSL
import NIOHPACK
import Logging
import RxSwift

class LndNioConnection {
    enum RequestType {
        case unary
        case serverStream
        case clientStream
        case biderectionalStream
    }
    
    private var available: Bool? = nil

    deinit {
        group.shutdownGracefully({_ in})
    }

    private let group: MultiThreadedEventLoopGroup
    let lightningClient: Lnrpc_LightningServiceClient
    
    init(rpcCredentials: RpcCredentials) throws {
        group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        let certificateBytes: [UInt8] = Array(rpcCredentials.certificate.utf8)
        let certificate = try NIOSSLCertificate(bytes: certificateBytes, format: .pem)
        let tlsConfig = ClientConnection.Configuration.TLS(
            trustRoots: .certificates([certificate])
        )

        let callOptions = CallOptions(
            customMetadata: HPACKHeaders([("macaroon", rpcCredentials.macaroon)])
        )

        let connectivityStateManager = ConnectivityStateManager()

        let config = ClientConnection.Configuration(
            target: .hostAndPort(rpcCredentials.host, rpcCredentials.port),
            eventLoopGroup: group,
            connectivityStateDelegate: connectivityStateManager,
            tls: tlsConfig
        )

        let connection = ClientConnection(configuration: config)

        lightningClient = Lnrpc_LightningServiceClient(connection: connection, defaultCallOptions: callOptions)
        connectivityStateManager.listener = self
    }
    
    func requestLightningService<T>(_ callType: RequestType, _ callFunction: (Lnrpc_LightningServiceClient) -> EventLoopFuture<T>) -> Single<T> {
        
        if let available = self.available, !available {
            return Single.error(GRPCStatus(code: .unavailable, message: "Not connected to remote node"))
        }

        return callFunction(lightningClient).toSingle()
    }
}

extension LndNioConnection: ConnectivityStateListener {
    func connectivityStateDidChange(to newState: ConnectivityState) {
        if newState == .ready {
            available = true
        } else if newState == .transientFailure {
            available = false
        }
    }
}
