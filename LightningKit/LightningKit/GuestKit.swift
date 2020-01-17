import GRPC
import NIO
import NIOSSL
import NIOHPACK

public class GuestKit {

    public static func testRemoteNode(credentials: RpcCredentials) {
        print("Testing Connection: \(credentials)")

        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        defer {
            try? group.syncShutdownGracefully()
        }

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

        let request = Lnrpc_ChannelBalanceRequest()
        let call = client.channelBalance(request)
        
        do {
            let response = try call.response.wait()

            print("Response: balance: \(response.balance)")
        } catch {
            print("ERROR: \(error): \(error.localizedDescription)")
        }
    }

}
