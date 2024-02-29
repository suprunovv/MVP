// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipesCoordinator: BaseCoordinator {
    private(set) var navigationController: UINavigationController?

    override func start() {
        guard let recipesModuleView = ModuleBuilder.makeRecipesModule(coordinator: self) as? RecipesViewController
        else { return }
        navigationController = UINavigationController(rootViewController: recipesModuleView)
    }

    func showCategory() {
        guard let categoryModule = ModuleBuilder.makeCategoryModule(coordinator: self) as? CategoryViewController
        else { return }
        navigationController?.pushViewController(categoryModule, animated: true)
    }
}
