// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор профиля
final class ProfileCoordinator: BaseCoordinator {
    private(set) var navigationController: UINavigationController?

    override func start() {
        guard let profileModuleView = ModuleBuilder.makeProfileModule(coordinator: self) as? ProfileViewController
        else { return }
        navigationController = UINavigationController(rootViewController: profileModuleView)
    }
}
