// RecipesModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сборщик модуля рецептов
final class RecipesModuleBuilder {
    private enum Constants {
        static let title = "Recipes"
    }

    static func makeModule() -> UIViewController {
        // TODO: replace with real VC
        let viewController = UIViewController()
//        let recipesPresenter = RecipesPresenter(view: viewController)
//        viewController.presenter = recipesPresenter
        viewController.tabBarItem = UITabBarItem(
            title: Constants.title,
            image: .cakeBarIcon,
            selectedImage: .cakeFullBarIcon
        )
        return viewController
    }
}
