// RecipelyAppTabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таббар приложения
final class RecipelyAppTabBarController: UITabBarController {
    // MARK: - Constants

    enum Constants {
        static let recipesTitle = "Recipes"
        static let favoritesTitle = "Favorites"
        static let profileTitle = "Profile"
        static let borderToScreenSpacing = 8.0
    }

    // MARK: - Visual Components

    private let topBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .greenBgAccent
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    // MARK: - Private Methods

    private func setupTabBar() {
        setViewControllers([
            createRecipesNavigationController(),
            createFavoritesNavigationController(),
            createProfileNavigationController()
        ], animated: false)

        setupAppearance()
        setupBorderTop()
    }

    private func setupAppearance() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .systemBackground
        UITabBar.appearance().tintColor = .greenAccent
        UITabBarItem.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor.greenAccent
        ], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([
            .font: UIFont.verdana(ofSize: 10) ?? UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.grayText
        ], for: .normal)
    }

    private func setupBorderTop() {
        tabBar.addSubview(topBorder)
        [
            topBorder.topAnchor.constraint(equalTo: tabBar.topAnchor),
            topBorder.leadingAnchor.constraint(
                equalTo: tabBar.leadingAnchor,
                constant: Constants.borderToScreenSpacing
            ),
            topBorder.trailingAnchor.constraint(
                equalTo: tabBar.trailingAnchor,
                constant: -Constants.borderToScreenSpacing
            )
        ].forEach { $0.isActive = true }
    }

    private func createRecipesNavigationController() -> UINavigationController {
        let recipesNavigationController = UINavigationController(rootViewController: UIViewController())
        recipesNavigationController.tabBarItem = UITabBarItem(
            title: Constants.recipesTitle,
            image: .cakeBarIcon,
            selectedImage: .cakeFullBarIcon
        )
        return recipesNavigationController
    }

    private func createFavoritesNavigationController() -> UINavigationController {
        let favoritesNavigationController =
            UINavigationController(rootViewController: UIViewController())
        favoritesNavigationController.tabBarItem = UITabBarItem(
            title: Constants.favoritesTitle,
            image: .bookmarkBarIcon,
            selectedImage: .bookmarkFullBarIcon
        )
        return favoritesNavigationController
    }

    private func createProfileNavigationController() -> UINavigationController {
        let profileNavigationController = UINavigationController(rootViewController: UIViewController())
        profileNavigationController.tabBarItem = UITabBarItem(
            title: Constants.profileTitle,
            image: .profileBarIcon,
            selectedImage: .profileFullBarIcon
        )
        return profileNavigationController
    }
}
