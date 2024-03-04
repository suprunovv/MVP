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
    /// Метод для получения состояниия кнопки калории
    func stateByCalories(state: SortingButton.SortState)
    /// Метод для получения состояния кнопки time
    func stateByTime(state: SortingButton.SortState)
}

/// Презентер экрана категории
final class CategoryPresenter {
    // MARK: - private propertise

    private weak var view: CategoryViewProtocol?
    private weak var coordinator: RecipesCoordinator?
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

    private(set) var recipes: [Recipe] = [] {
        didSet {
            view?.reloadRecipeTabel()
        }
    }

    // MARK: - initializators

    init(view: CategoryViewProtocol, coordinator: RecipesCoordinator, category: RecipesCategory) {
        self.view = view
        self.coordinator = coordinator
        recipes = RecipesDataSource.recipesByCategories[category.type] ?? []
        view.setScreenTitle(category.name)
    }

    private func sortRecipes(by timeSortState: SortingButton.SortState, caloriesSortState: SortingButton.SortState) {
        recipes.sort { recipe1, recipe2 in
            if timeSortState == .ascending {
                if recipe1.cookingTime != recipe2.cookingTime {
                    return recipe1.cookingTime > recipe2.cookingTime
                }
            } else if timeSortState == .descending {
                if recipe1.cookingTime != recipe2.cookingTime {
                    return recipe1.cookingTime < recipe2.cookingTime
                }
            }
            if caloriesSortState == .ascending {
                return recipe1.calories > recipe2.calories
            } else if caloriesSortState == .descending {
                return recipe1.calories < recipe2.calories
            }
            return true
        }
    }
}

// MARK: - CategoryPresenter + CategoryPresenterProtocol

extension CategoryPresenter: CategoryPresenterProtocol {
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
