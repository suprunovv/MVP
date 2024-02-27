// ProfileModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ProfileModuleBuilder: Builder {
    private enum Constants {
        static let title = "Profile"
    }

    static func makeModule() -> UIViewController {
        // TODO: replace with real VC
        let viewController = UIViewController()
//        let profilePresenter = ProfilePresenter(view: viewController)
//        viewController.presenter = profilePresenter
        viewController.tabBarItem = UITabBarItem(
            title: Constants.title,
            image: .profileBarIcon,
            selectedImage: .profileFullBarIcon
        )
        return viewController
    }
}
