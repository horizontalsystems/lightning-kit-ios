import LightningKit

class SecureStorage {
    private let storage: ICodableStorage

    init(storage: ICodableStorage) {
        self.storage = storage
    }

    private let keyRpcCredentials = "rpc_credentials"
    var rpcCredentials: RpcCredentials? {
        get {
            storage.get(key: keyRpcCredentials)
        }
        set {
            storage.save(object: newValue, key: keyRpcCredentials)
        }
    }

}
