// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class RecipesCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController

    init(rootController: UIViewController) {
        navigationController = UINavigationController(rootViewController: rootController)
    }

    override func start() {}
}
