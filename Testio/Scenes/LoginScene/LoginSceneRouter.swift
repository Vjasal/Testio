import Foundation

protocol LoginSceneRouterProtocol {
    var entry: LoginSceneViewController? { get }
    
    func navigateToServerListScene()
}

class LoginSceneRouter: LoginSceneRouterProtocol {
    weak var entry: LoginSceneViewController?
    
    func navigateToServerListScene() {
        let viewController = ServersSceneViewController()
        ServersSceneConfigurator.configureModule(viewController: viewController)
        entry?.navigationController?.pushViewController(viewController, animated: true)
    }
}
