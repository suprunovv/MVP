// AuthCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор авторизации
final class AuthCoordinator: BaseCoordinator {
    var finishFlowHandler: (() -> ())?
    private var navigationController: UINavigationController?

    override func start() {
        guard let authModuleView = AuthModuleBuilder.makeModule() as? LoginViewController else { return }
        navigationController = UINavigationController(rootViewController: authModuleView)
        authModuleView.presenter?.authCoordinator = self
        if let navigationController = navigationController {
            setAsRoot(navigationController)
        }
    }

    func didLogin() {
        finishFlowHandler?()
    }
}
