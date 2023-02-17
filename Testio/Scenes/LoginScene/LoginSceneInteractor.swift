import Foundation

protocol LoginSceneInteractorProtocol {
    var presenter: LoginScenePresenterProtocol? { get set }
    func login(username: String, password: String) async
    func getServers(token: String) async
}

class LoginSceneInteractor: LoginSceneInteractorProtocol {
    
    var presenter: LoginScenePresenterProtocol?
    
    var authWorker = LoginAuthWorker()
    var serverListWorker = ServerListWorker()
    
    func login(username: String, password: String) async {
        do {
            let token = try await authWorker.performLoginRequest(username: username, password: password)
            presenter?.handleLoginSuccess(token: token)
        } catch {
            presenter?.handleLoginError(error)
        }
    }
    
    func getServers(token: String) async {
        let savedServers = ServerCoreDataWorker.shared.fetch()
        guard savedServers.isEmpty else {
            presenter?.handleServersReceived()
            return
        }
        
        do {
            let servers = try await serverListWorker.fetchServerList(token: token)
            ServerCoreDataWorker.shared.save(servers: servers)
            presenter?.handleServersReceived()
        } catch {
            presenter?.handleServersError(error)
        }
    }
}
