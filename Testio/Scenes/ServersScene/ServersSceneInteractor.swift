import Foundation

protocol ServersSceneInteractorProtocol {
    var presenter: ServersScenePresenterProtocol? { get set }
    func logout()
}

class ServersSceneInteractor: ServersSceneInteractorProtocol {
    
    var presenter: ServersScenePresenterProtocol?
    
    func logout() {
        ServerCoreDataWorker.shared.deleteAll()
        presenter?.handleLogout()
    }
    
}
