import Foundation

protocol ServersSceneInteractorProtocol {
    var presenter: ServersScenePresenterProtocol? { get set }
    func loadServers()
    func logout()
}

class ServersSceneInteractor: ServersSceneInteractorProtocol {
    
    var presenter: ServersScenePresenterProtocol?
    
    func loadServers() {
        let servers = ServerCoreDataWorker.shared.fetch()
        presenter?.handleServersLoaded(servers)
    }
    
    func logout() {
        KeychainWorker.shared.deleteCredentials()
        ServerCoreDataWorker.shared.deleteAll()
        presenter?.handleLogout()
    }
    
}
