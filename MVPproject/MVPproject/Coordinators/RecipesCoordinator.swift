// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class RecipesCoordinator: BaseCoordinator {
    private(set) var rootController: UINavigationController

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    override func start() {}
}
