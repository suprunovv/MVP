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

    func showCategory(category: RecipesCategory) {
        guard let categoryModule = ModuleBuilder.makeCategoryModule(
            coordinator: self,
            category: category
        ) as? CategoryViewController
        else { return }
        navigationController?.pushViewController(categoryModule, animated: true)
    }

    func closeCategory() {
        guard (navigationController?.viewControllers.last as? CategoryViewController) != nil else {
            return
        }
        navigationController?.popViewController(animated: true)
    }
}
