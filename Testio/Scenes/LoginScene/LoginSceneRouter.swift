import Foundation

protocol LoginSceneRouterProtocol {
    var entry: LoginSceneViewController? { get }
    
    func navigateToServerListScene(servers: [Server])
}

class LoginSceneRouter: LoginSceneRouterProtocol {
    weak var entry: LoginSceneViewController?
    
    func navigateToServerListScene(servers: [Server]) {
        let viewController = ServersSceneViewController(servers: servers)
        ServersSceneConfigurator.configureModule(viewController: viewController)
        entry?.navigationController?.pushViewController(viewController, animated: true)
    }
}
