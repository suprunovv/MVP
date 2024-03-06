// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категории
protocol CategoryPresenterProtocol: AnyObject {
    /// Рецепты в категории
    var recipes: [Recipe] { get }
    ///
    var loadingState: CategoryPresenter.LoadingState { get }
    /// Запрос на закрытие категории
    func closeCategory()
    /// Переход на экран с детальным описанием рецепта
    func showRecipeDetails(recipe: Recipe)
    /// Метод для получения состояниия кнопки калории
    func stateByCalories(state: SortingButton.SortState)
    /// Метод для получения состояния кнопки time
    func stateByTime(state: SortingButton.SortState)
    /// Обновление строки в поиске
    func updateSearchTerm(_ search: String)
}

/// Презентер экрана категории
final class CategoryPresenter {
    enum LoadingState {
        case initial
        case loading
        case loaded
    }

    // MARK: - private propertise

    private weak var view: CategoryViewProtocol?
    private weak var coordinator: RecipesCoordinator?

    private let recipesPlaceholder = Array(repeating: RecipesDataSource.recipePlaceholder, count: 7)
    private var timeSortingState = SortingButton.SortState.unsorted {
        didSet {
            sortRecipes(by: timeSortingState, caloriesSortState: caloriesSortingState)
        }
    }

    private var caloriesSortingState = SortingButton.SortState.unsorted {
        didSet {
            sortRecipes(by: timeSortingState, caloriesSortState: caloriesSortingState)
        }
    }

    private(set) var loadingState: LoadingState = .initial {
        didSet {
            if loadingState == .loading {
                recipes = recipesPlaceholder
            }
        }
    }

    private var recipesBeforeFiltering: [Recipe] = []

    private(set) var recipes: [Recipe] = [] {
        didSet {
            updateRecipesView()
        }
    }

    // MARK: - initializators

    init(view: CategoryViewProtocol, coordinator: RecipesCoordinator, category: RecipesCategory) {
        self.view = view
        self.coordinator = coordinator
        view.setScreenTitle(category.name)
        loadRecipes(byCategory: category)
    }

    private func loadRecipes(byCategory category: RecipesCategory) {
        loadingState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.loadingState = .loaded
            self?.recipes = RecipesDataSource.recipesByCategories[category.type] ?? []
        }
    }

    private func updateRecipesView() {
        view?.reloadRecipeTable()
        if recipes.isEmpty {
            view?.showEmptyMessage()
        } else {
            view?.hideEmptyMessage()
        }
    }

    private func sortRecipes(by timeSortState: SortingButton.SortState, caloriesSortState: SortingButton.SortState) {
        recipes.sort { recipe1, recipe2 in
            if timeSortState == .ascending, recipe1.cookingTime != recipe2.cookingTime {
                return recipe1.cookingTime > recipe2.cookingTime
            }
            if timeSortState == .descending, recipe1.cookingTime != recipe2.cookingTime {
                return recipe1.cookingTime < recipe2.cookingTime
            }
            if caloriesSortState == .ascending {
                return recipe1.calories > recipe2.calories
            }
            if caloriesSortState == .descending {
                return recipe1.calories < recipe2.calories
            }
            return true
        }
    }
}

// MARK: - CategoryPresenter + CategoryPresenterProtocol

extension CategoryPresenter: CategoryPresenterProtocol {
    func updateSearchTerm(_ search: String) {
        if recipesBeforeFiltering.isEmpty {
            recipesBeforeFiltering = recipes
        }
        if search.count < 3 {
            if recipes.count != recipesBeforeFiltering.count {
                recipes = recipesBeforeFiltering
                recipesBeforeFiltering = []
            }
            return
        }
        recipes = recipesBeforeFiltering.filter { recipe in
            recipe.name.range(of: search, options: [.caseInsensitive, .diacriticInsensitive]) != nil
        }
    }

    func stateByTime(state: SortingButton.SortState) {
        timeSortingState = state
    }

    func stateByCalories(state: SortingButton.SortState) {
        caloriesSortingState = state
    }

    func closeCategory() {
        coordinator?.closeCategory()
    }

    func showRecipeDetails(recipe: Recipe) {
        coordinator?.showDetails(recipe: recipe)
    }
}
