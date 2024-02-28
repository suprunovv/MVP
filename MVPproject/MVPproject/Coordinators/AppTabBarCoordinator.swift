// AppTabBarCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор таббара
final class AppTabBarCoordinator: BaseCoordinator {
    private var tabBarViewController: RecipelyAppTabBarController?

    override func start() {
        tabBarViewController = RecipelyAppTabBarController()
        /// Set Recipes
        let recipesModuleView = RecipesModuleBuilder.makeModule()
        let recipesCoordinator = RecipesCoordinator(rootController: recipesModuleView)
        // TODO: uncomment when presenter is implemented for that flow
//        recipesModuleView.presenter?.recipesCoordinator = recipesCoordinator
        add(coordinator: recipesCoordinator)

        /// Set Favorites
        let favoritesModuleView = FavoritesModuleBuilder.makeModule()
        let favoritesCoordinator = FavoritesCoordinator(rootController: favoritesModuleView)
        // TODO: uncomment when presenter is implemented for that flow
//        favoritesModuleView.presenter?.favoritesCoordinator = favoritesCoordinator
        add(coordinator: favoritesCoordinator)

        /// Set Profile
        let profileModuleView = ProfileModuleBuilder.makeModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileModuleView)
        // TODO: uncomment when presenter is implemented for that flow
//        profileModuleView.presenter?.profileCoordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        tabBarViewController?.setViewControllers(
            [recipesCoordinator.rootController, favoritesCoordinator.rootController, profileCoordinator.rootController],
            animated: false
        )

        if let tabBarViewController = tabBarViewController {
            setAsRoot(tabBarViewController)
        }
    }
}
