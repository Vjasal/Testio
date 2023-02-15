//
//  ServerListConfigurator.swift
//  Testio
//
//  Created by Hubert Rytel on 10/02/2023.
//

import Foundation

class ServersSceneConfigurator {
    static func configureModule(viewController: ServersSceneViewController) {
        let interactor = ServersSceneInteractor()
        let presenter = ServersScenePresenter()
        let router = ServersSceneRouter()
        let view = ServersSceneView()
        
        viewController.router = router
        viewController.interactor = interactor
        viewController.sceneView = view
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.entry = viewController
    }
}
