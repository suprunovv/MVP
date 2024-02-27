// FavoritesModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FavoritesModuleBuilder: Builder {
    private enum Constants {
        static let title = "Favorites"
    }

    static func makeModule() -> UIViewController {
        // TODO: replace with real VC
        let viewController = UIViewController()
//        let favoritesPresenter = FavoritesPresenter(view: viewController)
//        viewController.presenter = favoritesPresenter
        viewController.tabBarItem = UITabBarItem(
            title: Constants.title,
            image: .bookmarkBarIcon,
            selectedImage: .bookmarkFullBarIcon
        )
        return viewController
    }
}
