// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import Swinject
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        setupWindow(withScene: scene)
    }

    private func setupWindow(withScene scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        appCoordinator = AppCoordinator()
        appCoordinator?.start()
    }

    static func setContainer() -> Container {
        let container = Container()
        container.register(LoadImageService.self) { _ in LoadImageService() }.inObjectScope(.container)
        container.register(NetworkService.self) { _ in NetworkService() }.inObjectScope(.container)
        container.register(LoadImageProxy.self) { result in
            LoadImageProxy(service: result.resolve(LoadImageService.self))
        }.inObjectScope(.container)
        return container
    }
}
