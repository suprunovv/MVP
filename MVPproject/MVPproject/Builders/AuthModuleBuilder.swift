// AuthModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AuthModuleBuilder: Builder {
    static func makeModule() -> UIViewController {
        let viewController = LoginViewController()
//        let presenter = LoginPresenter(view: viewController)
        return viewController
    }
}
