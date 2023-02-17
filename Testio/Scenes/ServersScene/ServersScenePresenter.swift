import Foundation

protocol ServersScenePresenterProtocol {
    var viewController: ServersSceneViewControllerProtocol? { get set }
    func handleServersLoaded(_ servers: [Server])
    func handleLogout()
}

class ServersScenePresenter: ServersScenePresenterProtocol {
    
    weak var viewController: ServersSceneViewControllerProtocol?
    
    func handleServersLoaded(_ servers: [Server]) {
        viewController?.handleServersLoaded(servers)
    }
    
    func handleLogout() {
        viewController?.handleLogoutDone()
    }
}
