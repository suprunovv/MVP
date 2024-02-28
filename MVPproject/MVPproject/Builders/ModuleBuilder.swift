// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сборщик модуля авторизации
final class ModuleBuilder {
    private enum Constants {
        static let recipesTitle = "Recipes"
        static let favoritrsTitle = "Favorites"
        static let profileTitle = "Profile"
    }

    static func makeLoginModule(coordinator: AuthCoordinator) -> UIViewController {
        let viewController = LoginViewController()
        let presenter = LoginPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = presenter
        return viewController
    }

    static func makeRecipesModule() -> UIViewController {
        // TODO: replace with real VC and setup presenter
        let viewController = UIViewController()
//        let recipesPresenter = RecipesPresenter(view: viewController)
//        viewController.presenter = recipesPresenter
        viewController.tabBarItem = UITabBarItem(
            title: Constants.recipesTitle,
            image: .cakeBarIcon,
            selectedImage: .cakeFullBarIcon
        )
        return viewController
    }

    static func makeFavoritesModule() -> UIViewController {
        // TODO: replace with real VC and setup presenter
        let viewController = UIViewController()
//        let favoritesPresenter = FavoritesPresenter(view: viewController)
//        viewController.presenter = favoritesPresenter
        viewController.tabBarItem = UITabBarItem(
            title: Constants.favoritrsTitle,
            image: .bookmarkBarIcon,
            selectedImage: .bookmarkFullBarIcon
        )
        return viewController
    }

    static func makeProfileModule(coordinator: ProfileCoordinator) -> UIViewController {
        let viewController = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = profilePresenter
        viewController.tabBarItem = UITabBarItem(
            title: Constants.profileTitle,
            image: .profileBarIcon,
            selectedImage: .profileFullBarIcon
        )
        return viewController
    }
}
