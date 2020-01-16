import SwiftGRPC

public class GuestKit {

    public static func testRemoteNode(address: String, certificate: String, macaroon: String) {
//        print("Testing Connection:\n\nAddress: \(address)\nCertificate: \(certificate)\nMacaroon: \(macaroon)")

        let client = Lnrpc_LightningServiceClient(address: address, certificates: certificate)

        client.metadata = try! Metadata([
            "macaroon": macaroon
        ])

        let service: Lnrpc_LightningService = client

        let request = Lnrpc_ChannelBalanceRequest()

        do {
            let response = try service.channelBalance(request)

            print("Response: balance: \(response.balance)")
        } catch {
            print("ERROR: \(error): \(error.localizedDescription)")
        }

    }

}
