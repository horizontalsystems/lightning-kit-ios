import GRPC
import NIO
import NIOSSL
import NIOHPACK

public class Kit {
    deinit {
        try? group?.syncShutdownGracefully()
    }
    
    public enum WalletState {
        case connecting
        case locked
        case syncing
        case running
        case error
    }

    public var state: WalletState
    var group: EventLoopGroup?
    var connection: ClientConnection?

    public init(credentials: RpcCredentials) {
        print("Testing Connection: \(credentials)")
        state = .connecting

        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        let certificateBytes: [UInt8] = Array(credentials.certificate.utf8)
        let certificate = try! NIOSSLCertificate(bytes: certificateBytes, format: .pem)
        let tlsConfig = ClientConnection.Configuration.TLS(
            trustRoots: .certificates([certificate]),
            hostnameOverride: "localhost"
        )

        let callOptions = CallOptions(
            customMetadata: HPACKHeaders([("macaroon", credentials.macaroon)])
        )

        let config = ClientConnection.Configuration(
          target: .hostAndPort(credentials.host, credentials.port),
          eventLoopGroup: group,
          tls: tlsConfig
        )

        let connection = ClientConnection(configuration: config)
        let client = Lnrpc_LightningServiceClient(connection: connection, defaultCallOptions: callOptions)

        let request = Lnrpc_GetInfoRequest()
        let call = client.getInfo(request)

        do {
            let response = try call.response.wait()
            
            state = response.syncedToChain ? .running : .syncing
            print("Response: node alias: \(response.alias); state: \(state)")
        } catch let error as GRPCStatus {
            if error.code == .unimplemented {
                state = .locked
                print("Wallet locked")
            } else {
                state = .error
                print("ERROR: \(error): \(error.localizedDescription)")
            }
        } catch {
            state = .error
            print("ERROR: \(error): \(error.localizedDescription)")
        }

        self.group = group
        self.connection = connection
    }

}
