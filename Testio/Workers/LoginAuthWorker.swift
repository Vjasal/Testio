import Foundation

enum LoginAuthWorkerError: Error {
    case invalidUrl
    case invalidResponse
}

class LoginAuthWorker {
    
    func performLoginRequest(username: String, password: String) async throws -> String {
        guard let url = URL(string: Constants.tokenApiEndpoint) else { throw LoginAuthWorkerError.invalidUrl }
        let requestBody = AuthRequest(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(requestBody)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        
        guard let token = response.token else { throw LoginAuthWorkerError.invalidResponse }
        return token
    }
    
}
