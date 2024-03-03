// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокл презентера избранных рецептов
protocol FavoritesPresenterProtocol: AnyObject {
    /// Избранные рецепты
    var favoriteRecipes: [Recipe] { get }
    /// Запрос на открытие деталей о рецепте
    func showRecipeDetails(recipe: Recipe)
    /// Обновить избранное
    func refreshFavorites()
}

/// Презентер избранных рецептов
final class FavoritesPresenter {
    private weak var view: FavoritesViewProtocol?
    private weak var coordinator: FavoritesCoordinator?

    private(set) var favoriteRecipes: [Recipe] = RecipesDataSource.recipes

    init(view: FavoritesViewProtocol, coordinator: FavoritesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - FavoritesPresenter + FavoritesPresenterProtocol

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func refreshFavorites() {
        if favoriteRecipes.isEmpty {
            view?.showEmptyMessage()
        } else {
            view?.showFavorites()
        }
    }

    func showRecipeDetails(recipe: Recipe) {
        coordinator?.showDetails(recipe: recipe)
    }
}
