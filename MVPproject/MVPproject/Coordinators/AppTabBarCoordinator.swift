// AppTabBarCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор таббара
final class AppTabBarCoordinator: BaseCoordinator {
    private var recipelyAppTabBarController: RecipelyAppTabBarController?

    override func start() {
        recipelyAppTabBarController = RecipelyAppTabBarController()
        /// Set Recipes
        let recipesCoordinator = RecipesCoordinator()
        recipesCoordinator.start()
        add(coordinator: recipesCoordinator)

        /// Set Favorites
        let favoritesModuleView = ModuleBuilder.makeFavoritesModule()
        let favoritesCoordinator = FavoritesCoordinator(rootController: favoritesModuleView)
        // TODO: uncomment when presenter is implemented for that flow
//        favoritesModuleView.presenter?.favoritesCoordinator = favoritesCoordinator
        add(coordinator: favoritesCoordinator)

        /// Set Profile
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.start()
        add(coordinator: profileCoordinator)

        recipelyAppTabBarController?.setViewControllers(
            [
                recipesCoordinator.navigationController,
                favoritesCoordinator.rootController,
                profileCoordinator.navigationController
            ].compactMap { $0 },
            animated: false
        )

        if let tabBarViewController = recipelyAppTabBarController {
            setAsRoot(tabBarViewController)
        }
    }
}
