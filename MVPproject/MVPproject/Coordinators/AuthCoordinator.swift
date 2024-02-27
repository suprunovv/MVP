// AuthCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AuthCoordinator: BaseCoordinator {
    var finishFlowHandler: (() -> ())?
    private var navigationController: UINavigationController!

    override func start() {
        let authModuleView = AuthModuleBuilder.makeModule()
        navigationController = UINavigationController(rootViewController: authModuleView)
        authModuleView.presenter?.authCoordinator = self
        setAsRoot(navigationController)
    }

    func didLogin() {
        finishFlowHandler?()
    }
}
