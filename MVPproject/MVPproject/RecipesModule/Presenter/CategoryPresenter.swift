// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол презентера экрана категории
protocol CategoryPresenterProtocol: AnyObject {
    /// Рецепты в категории
    var recipes: [Recipe] { get }
    /// Запрос на закрытие категории
    func closeCategory()
    /// Переход на экран с детальным описанием рецепта
    func showRecipeDetails(recipe: Recipe)
}

/// Презентер экрана категории
final class CategoryPresenter {
    // MARK: - private propertise

    private weak var view: CategoryViewProtocol?
    private weak var coordinator: RecipesCoordinator?

    private(set) var recipes: [Recipe] = []

    // MARK: - initializators

    init(view: CategoryViewProtocol, coordinator: RecipesCoordinator, category: RecipesCategory) {
        self.view = view
        self.coordinator = coordinator
        recipes = RecipesDataSource.recipesByCategories[category.type] ?? []
        view.setScreenTitle(category.name)
    }
}

// MARK: - CategoryPresenter + CategoryPresenterProtocol

extension CategoryPresenter: CategoryPresenterProtocol {
    func closeCategory() {
        coordinator?.closeCategory()
    }

    func showRecipeDetails(recipe: Recipe) {
        coordinator?.showDetail(recipe: recipe)
    }
}
