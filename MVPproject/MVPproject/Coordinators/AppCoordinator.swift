// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор приложения опредляющий флоу Auth или Main
final class AppCoordinator: BaseCoordinator {
    override func start() {
        switch App.shared.state {
        case .unauthorized:
            toAuth()
        case .loggedIn:
            toMain()
        }
    }

    private func toMain() {
        let tabBarCoordinator = AppTabBarCoordinator()
        add(coordinator: tabBarCoordinator)
        tabBarCoordinator.start()
    }

    private func toAuth() {
        let authCoordinator = AuthCoordinator()
        authCoordinator.finishFlowHandler = { [weak self] in
            self?.remove(coordinator: authCoordinator)
            self?.toMain()
        }
        add(coordinator: authCoordinator)
        authCoordinator.start()
    }
}
