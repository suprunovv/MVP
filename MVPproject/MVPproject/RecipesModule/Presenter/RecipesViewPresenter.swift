// RecipesViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для презентера экрана рецептов
protocol RecipesPresenterProtocol: AnyObject {
    /// Метод показывает выбранную категорию рецепта
    func showRecipesByCategory(category: RecipesCategoryCellConfig)
    /// Метод посылает на вью данные о категориях
    func getRecipesCategory()
}

/// Презентер для экрана с типами рецептов

final class RecipesViewPresenter {
    private weak var view: RecipesViewProtocol?
    private weak var recipesCoordinator: RecipesCoordinator?

    init(view: RecipesViewProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        recipesCoordinator = coordinator
    }
}

// MARK: - RecipesViewPresenter + RecipesPresenterProtocol

extension RecipesViewPresenter: RecipesPresenterProtocol {
    func getRecipesCategory() {
        let categories = RecipesCategoriesCollectionConfig.getRecipesCategoryCellConfigs()
        view?.updateRecipes(categories: categories)
    }

    func showRecipesByCategory(category: RecipesCategoryCellConfig) {
        // TODO: - Сюда придет модель c ячейки на которую мы нажали, ее будем передавать на следующий экран (Завтра обсудим)
        recipesCoordinator?.showCategory()
    }
}
