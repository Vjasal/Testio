import Foundation

enum KeychainWorkerError: Error {
    case duplicateEntry
    case unknown(OSStatus)
}

class KeychainWorker {
    
    static let shared = KeychainWorker()
    
    let service = "com.vjasal.testio"
    let usernameAccount = "username"
    let passwordAccount = "password"
    
    func hasCredentials() -> Bool {
        return getCredentials() != nil
    }
    
    func saveCredentials(username: String, password: String) throws {
        guard let usernameData = username.data(using: .utf8) else { return }
        guard let passwordData = password.data(using: .utf8) else { return }
        deleteCredentials()
        try save(service: service, account: usernameAccount, data: usernameData)
        try save(service: service, account: passwordAccount, data: passwordData)
    }
    
    func getCredentials() -> (String, String)? {
        guard let usernameData = get(service: service, account: usernameAccount) else { return nil }
        guard let passwordData = get(service: service, account: passwordAccount) else { return nil }
        
        let username = String(decoding: usernameData, as: UTF8.self)
        let password = String(decoding: passwordData, as: UTF8.self)
        
        return (username, password)
    }
    
    func deleteCredentials() {
        delete(service: service, account: usernameAccount)
        delete(service: service, account: passwordAccount)
    }
}

extension KeychainWorker {
    private func save(service: String, account: String, data: Data) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: data as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            return
        case errSecDuplicateItem:
            throw KeychainWorkerError.duplicateEntry
        default:
            throw KeychainWorkerError.unknown(status)
        }
    }
    
    private func get(service: String, account: String) -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else { return nil }
        
        return result as? Data
    }
    
    private func delete(service: String, account: String) {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
