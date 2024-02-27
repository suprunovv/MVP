// AuthCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AuthCoordinator: BaseCoordinator {
    var finishFlowHandler: (() -> ())?
    private var navigationController = UINavigationController()

    override func start() {
        let authModuleView = AuthModuleBuilder.makeModule()
//        authModuleView.presenter?.authCoordinator = self
        setAsRoot(authModuleView)
    }

    func didLogin() {
        finishFlowHandler?()
    }
}
