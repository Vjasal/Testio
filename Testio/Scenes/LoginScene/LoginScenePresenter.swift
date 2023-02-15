import Foundation

protocol LoginScenePresenterProtocol {
    var viewController: LoginSceneViewControllerProtocol? { get set }
    
    func handleLoginSuccess(token: String)
    func handleLoginError(_ error: Error)
    func handleServersReceived(servers: [Server])
    func handleServersError(_ error: Error)
}

class LoginScenePresenter: LoginScenePresenterProtocol {
    
    weak var viewController: LoginSceneViewControllerProtocol?
    
    func handleLoginSuccess(token: String) {
        self.viewController?.handleLoginSuccess(token: token)
    }
    
    func handleLoginError(_ error: Error) {
        DispatchQueue.main.async {
            self.viewController?.hideLoadingServerListIndicator()
            self.viewController?.showLoginErrorAlert(error)
        }
    }
    
    func handleServersReceived(servers: [Server]) {
        DispatchQueue.main.async {
            self.viewController?.handleServerListReceived(servers)
        }
    }
    
    func handleServersError(_ error: Error) {
        DispatchQueue.main.async {
            self.viewController?.hideLoadingServerListIndicator()
            self.viewController?.showServerListError(error)
        }
    }
}
