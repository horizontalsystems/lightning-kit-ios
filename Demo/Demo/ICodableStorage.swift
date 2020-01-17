protocol ICodableStorage {
    func get<T: Decodable>(key: String) -> T?
    func save<T: Encodable>(object: T, key: String)
}
