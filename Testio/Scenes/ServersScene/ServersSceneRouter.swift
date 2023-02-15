import Foundation

protocol ServersSceneRouterProtocol {
    var entry: ServersSceneViewController? { get }
    
    func navigateToLoginScene()
}

class ServersSceneRouter: ServersSceneRouterProtocol {
    weak var entry: ServersSceneViewController?
    
    func navigateToLoginScene() {
        guard let entry = entry else { return }
        guard let viewControllersCount = entry.navigationController?.viewControllers.count else {
            fatalError("Unexpected application state")
        }
        
        if viewControllersCount > 1 {
            entry.navigationController?.popViewController(animated: true)
        } else {
            let loginSceneViewController = LoginSceneViewController()
            LoginSceneConfigurator.configureModule(viewController: loginSceneViewController)
            entry.navigationController?.viewControllers = [loginSceneViewController, entry]
            entry.navigationController?.popViewController(animated: true)
        }
    }
    
}
