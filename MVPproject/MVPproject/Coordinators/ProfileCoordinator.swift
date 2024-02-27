// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ProfileCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController

    init(rootController: UIViewController) {
        navigationController = UINavigationController(rootViewController: rootController)
    }
}
