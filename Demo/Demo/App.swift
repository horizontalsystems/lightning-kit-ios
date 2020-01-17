import LightningKit

class App {
    static let shared = App()

    private let codableStorage: ICodableStorage
    let secureStorage: SecureStorage
    var kit: Kit? = nil

    init() {
        codableStorage = UserDefaultsStorage()
        secureStorage = SecureStorage(storage: codableStorage)
    }

}
