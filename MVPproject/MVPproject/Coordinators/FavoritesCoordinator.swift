// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FavoritesCoordinator: BaseCoordinator {
    private(set) var rootController: UINavigationController

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
