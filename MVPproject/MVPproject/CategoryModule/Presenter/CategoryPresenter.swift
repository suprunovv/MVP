// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол презентера экрана категории
protocol CategoryPresenterProtocol: AnyObject {}
/// Презентер экрана категории
final class CategoryPresenter {
    // MARK: - private propertise

    private weak var view: CategoryViewProtocol?
    private weak var coordinator: RecipesCoordinator?

    // MARK: - initializators

    init(view: CategoryViewProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - CategoryPresenter + CategoryPresenterProtocol

extension CategoryPresenter: CategoryPresenterProtocol {}
