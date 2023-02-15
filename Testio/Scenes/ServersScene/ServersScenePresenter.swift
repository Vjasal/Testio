import Foundation

protocol ServersScenePresenterProtocol {
    var viewController: ServersSceneViewControllerProtocol? { get set }
    func handleLogout()
}

class ServersScenePresenter: ServersScenePresenterProtocol {
    
    weak var viewController: ServersSceneViewControllerProtocol?
    
    func handleLogout() {
        viewController?.handleLogoutDone()
    }
}
