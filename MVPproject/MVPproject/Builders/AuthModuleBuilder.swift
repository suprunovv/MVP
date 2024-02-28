// AuthModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сборщик модуля авторизации
final class AuthModuleBuilder: Builder {
    static func makeModule() -> UIViewController {
        let viewController = LoginViewController()
        let presenter = LoginPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
