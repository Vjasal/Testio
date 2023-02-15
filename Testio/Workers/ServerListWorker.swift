import Foundation

enum ServerListWorkerError: Error {
    case invalidUrl
}

class ServerListWorker {
    
    func fetchServerList(token: String) async throws -> [Server] {
        guard let url = URL(string: Constants.serverListApiEndpoint) else { throw ServerListWorkerError.invalidUrl }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Server].self, from: data)
    }
}
