import Foundation

protocol LoginScenePresenterProtocol {
    var viewController: LoginSceneViewControllerProtocol? { get set }
    
    func handleLoginSuccess(token: String)
    func handleLoginError(_ error: Error)
    func handleServersReceived()
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
    
    func handleServersReceived() {
        DispatchQueue.main.async {
            self.viewController?.handleServerListReceived()
        }
    }
    
    func handleServersError(_ error: Error) {
        DispatchQueue.main.async {
            self.viewController?.hideLoadingServerListIndicator()
            self.viewController?.showServerListError(error)
        }
    }
}
