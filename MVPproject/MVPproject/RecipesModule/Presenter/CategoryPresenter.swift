// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категории
protocol CategoryPresenterProtocol: AnyObject {
    /// Рецепты в категории
    var recipes: [Recipe] { get }
    /// Состояние загрузки
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
    /// Экран загружен
    func screenLoaded()
    /// // MARK: - Public Properties
    var viewState: ViewState<[Recipe]> { get }
}

/// Презентер экрана категории
final class CategoryPresenter {
    enum LoadingState {
        case initial
        case loading
        case loaded
    }

    //  var updateViewState: ((ViewState) -> ())?

    // MARK: - private propertise

    private let networkService: NetworkServiceProtocol
    private weak var view: CategoryViewProtocol?
    private weak var coordinator: RecipesCoordinator?
    private var uri: String?

    private let recipesPlaceholder = Array(repeating: RecipesMock.recipePlaceholder, count: 7)
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

    private(set) var viewState: ViewState<[Recipe]> = .loading {
        didSet {
            updateRecipesView()
        }
    }

    private(set) var loadingState: LoadingState = .initial {
        didSet {
            if loadingState == .loading {}
        }
    }

    private var category: RecipesCategory

    private var recipesBeforeFiltering: [Recipe] = []

    private(set) var recipes: [Recipe] = []

    // MARK: - initializators

    init(
        view: CategoryViewProtocol,
        coordinator: RecipesCoordinator,
        networkService: NetworkServiceProtocol,
        category: RecipesCategory
    ) {
        self.view = view
        self.coordinator = coordinator
        self.category = category
        self.networkService = networkService
        view.setScreenTitle(category.name)
        loadRecipes(byCategory: category)
    }

    private func loadRecipes(byCategory category: RecipesCategory) {
        viewState = .loading
        networkService.getRecipesByCategory(CategoryRequestDTO(category: category)) { [weak self] result in
            switch result {
            case let .success(data):
                if data.isEmpty {
                    self?.viewState = .noData
                } else {
                    self?.viewState = .data(data)
                }
            case let .failure(error):
                self?.viewState = .error(error)
                // TODO: handle error state
            }
        }
    }

    private func updateRecipesView() {
        view?.hideEmptyMessage()
        switch viewState {
        case .loading:
            recipes = recipesPlaceholder
            view?.reloadRecipeTable()
        case let .data(recipes):
            self.recipes = recipes
            view?.reloadRecipeTable()
        case .noData:
            view?.showEmptyMessage()
        case .error:
            view?.showEmptyMessage()
        }
    }

    private func sortRecipes(by timeSortState: SortingButton.SortState, caloriesSortState: SortingButton.SortState) {
        let sortedRecipes = recipes.sorted { recipe1, recipe2 in
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
        viewState = .data(sortedRecipes)
    }
}

// MARK: - CategoryPresenter + CategoryPresenterProtocol

extension CategoryPresenter: CategoryPresenterProtocol {
    func screenLoaded() {
        TxtFileLoggerInvoker.shared.log(.viewScreen(ScreenInfo(title: "Category")))
        TxtFileLoggerInvoker.shared.log(.openCategory(category))
    }

    func updateSearchTerm(_ search: String) {
        if recipesBeforeFiltering.isEmpty {
            recipesBeforeFiltering = recipes
        }

        viewState = .loading
        if search.count < 3 {
            if recipes.count != recipesBeforeFiltering.count {
                recipes = recipesBeforeFiltering
                recipesBeforeFiltering = []
            }
            loadingState = .loaded
            return
        }
        networkService.getRecipesByCategory(CategoryRequestDTO(
            category: category,
            searchTerm: search
        )) { [weak self] result in
            switch result {
            case .failure:
                // TODO: handle error
                self?.recipes = []
            case let .success(data):
                self?.recipes = data
            }
            self?.loadingState = .loaded
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
