// Builder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// билдер
final class Builder {
    func makeProfileModule() -> UIViewController {
        let presenter = LoginViewPresenter()
        let view = LoginViewController()
        presenter.view = view
        view.presenter = presenter
        return view
    }
}
