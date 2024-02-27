// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FavoritesCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController

    init(rootController: UIViewController) {
        navigationController = UINavigationController(rootViewController: rootController)
    }
}
