import UIKit

class LoginSceneConfigurator {
    
    static func configureModule(viewController: LoginSceneViewController) {
        let view = LoginSceneView()
        let interactor = LoginSceneInteractor()
        let presenter = LoginScenePresenter()
        let router = LoginSceneRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        viewController.loginView = view
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.entry = viewController
    }
}
