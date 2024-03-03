// RecipesPresenter.swift
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

final class RecipesPresenter {
    private weak var view: RecipesViewProtocol?
    private weak var recipesCoordinator: RecipesCoordinator?

    init(view: RecipesViewProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        recipesCoordinator = coordinator
    }
}

// MARK: - RecipesPresenter + RecipesPresenterProtocol

extension RecipesPresenter: RecipesPresenterProtocol {
    func getRecipesCategory() {
        let categories = RecipesCategoriesCollectionConfig.getRecipesCategoryCellConfigs()
        view?.updateRecipes(categories: categories)
    }

    func showRecipesByCategory(category: RecipesCategoryCellConfig) {
        recipesCoordinator?.showCategory(category: category.recipeCategory)
    }
}
