class App {
    static let shared = App()

    private let codableStorage: ICodableStorage
    let secureStorage: SecureStorage

    init() {
        codableStorage = UserDefaultsStorage()
        secureStorage = SecureStorage(storage: codableStorage)
    }

}
