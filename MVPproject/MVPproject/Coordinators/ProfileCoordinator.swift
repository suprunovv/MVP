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

    func showBonuses() {
        guard let bonusesModuleView = ModuleBuilder.makeBonusesModule(
            coordinator: self
        ) as? BonusesViewController else { return }
        if let sheet = bonusesModuleView.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 30
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        navigationController?.present(bonusesModuleView, animated: true)
    }
}
