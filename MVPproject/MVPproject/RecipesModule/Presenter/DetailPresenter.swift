// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол для презентера детального экрана
protocol DetailPresenterProtocol: AnyObject {
    /// Метод получает модель рецепта
    func getRecipe() -> Recipe
    /// Mассив типов ячеек
    var cellTypes: [DetailCellType] { get }
    /// Метод закрывает экран деталей
    func closeDetails()
    /// Экран загружен
    func screenLoaded()
    /// Пошарить рецепт
    func shareRecipe()
    /// Добавить рецепт в избранное
    func addFavoriteRecipe()
    /// Метод возвращает модель детального рецепта
    func getDetailsRecipe() -> Recipe
}

/// Перечисление возможных типов ячеек
enum DetailCellType {
    /// Ячейка с картинкой
    case image
    /// Ячейка с описанием энергетической ценности
    case energy
    /// Ячейка с описаниеп приготовления
    case description
}

/// Презентер детального экрана рецепта
final class DetailPresenter {
    // MARK: - Private properties

    private let networkService: NetworkServiceProtocol
    private(set) var cellTypes: [DetailCellType] = [.image, .energy, .description]
    private weak var view: DetailViewProtocol?
    private weak var coordinator: RecipeWithDetailsCoordinatorProtocol?
    private var recipe: Recipe

    // MARK: - Initializators

    init(
        view: DetailViewProtocol,
        coordinator: RecipeWithDetailsCoordinatorProtocol,
        networkService: NetworkServiceProtocol,
        recipe: Recipe
    ) {
        self.view = view
        self.coordinator = coordinator
        self.recipe = recipe
        self.networkService = networkService
        getDetails()
    }

    // MARK: - Private methods

    private func getDetails() {
        guard let uri = recipe.uri else { return }
        networkService.getRecipesDetailsByURI(uri, completion: { [weak self] result in
            switch result {
            case let .success(data):
                self?.recipe = data
            case let .failure(error):
                // TODO: implement handling error state
                print(error.localizedDescription)
            }
            self?.view?.reloadData()
        })
    }
}

// MARK: - DetailPresenter + DetailPresenterProtocol

extension DetailPresenter: DetailPresenterProtocol {
    func getDetailsRecipe() -> Recipe {
        recipe
    }

    func addFavoriteRecipe() {
        FavoriteRecipes.shared.updateFavoriteRecipe(recipe)
    }

    func shareRecipe() {
        TxtFileLoggerInvoker.shared.log(.shareRecipe(recipe))
    }

    func screenLoaded() {
        TxtFileLoggerInvoker.shared.log(.viewScreen(ScreenInfo(title: "Recipe details")))
        TxtFileLoggerInvoker.shared.log(.openDetails(recipe))
    }

    func closeDetails() {
        coordinator?.closeDetails()
    }

    func getRecipe() -> Recipe {
        recipe
    }
}
