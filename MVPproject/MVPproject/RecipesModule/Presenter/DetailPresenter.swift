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

    private(set) var cellTypes: [DetailCellType] = [.image, .energy, .description]
    private weak var view: DetailViewProtocol?
    private weak var coordinator: RecipeWithDetailsCoordinatorProtocol?
    private var recipe: Recipe
    private var uri: String
    private let networkService = NetworkService()

    // MARK: - Initializators

    init(view: DetailViewProtocol, coordinator: RecipeWithDetailsCoordinatorProtocol, recipe: Recipe, uri: String) {
        self.view = view
        self.coordinator = coordinator
        self.recipe = recipe
        self.uri = uri
        getDetails()
    }

    // MARK: - Private methods

    private func getDetails() {
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
