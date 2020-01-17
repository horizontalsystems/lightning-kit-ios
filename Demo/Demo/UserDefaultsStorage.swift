import Foundation

class UserDefaultsStorage {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
}

extension UserDefaultsStorage: ICodableStorage {

    func get<T: Decodable>(key: String) -> T? {
        guard let savedData = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }

        return try? decoder.decode(T.self, from: savedData)
    }

    func save<T: Encodable>(object: T, key: String) {
        guard let data = try? encoder.encode(object) else {
            return
        }

        UserDefaults.standard.set(data, forKey: key)
    }

}
