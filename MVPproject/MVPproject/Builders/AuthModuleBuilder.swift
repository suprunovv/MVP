// AuthModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AuthModuleBuilder {
    static func makeModule() -> LoginViewController {
        let viewController = LoginViewController()
        let presenter = LoginPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
