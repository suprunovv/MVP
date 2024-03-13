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
    /// Вью стейт
    var viewState: ViewState<Recipe> { get }
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
    private(set) var viewState: ViewState<Recipe> = .loading {
        didSet {
            updateDetailView()
        }
    }

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
        viewState = .loading
        guard let uri = recipe.uri else { return }
        networkService.getRecipesDetailsByURI(uri, completion: { [weak self] result in
            switch result {
            case let .success(data):
                if data.details == nil {
                    self?.viewState = .noData
                } else {
                    self?.viewState = .data(data)
                }
            case let .failure(error):
                self?.viewState = .error(error)
            }
            self?.view?.reloadData()
        })
    }

    private func updateDetailView() {
        view?.hideEmptyMessage()
        switch viewState {
        case .loading:
            view?.reloadData()
        case let .data(recipe):
            self.recipe = recipe
            view?.reloadData()
        case .noData:
            view?.showEmptyMessage()
        case let .error(error):
            view?.showErrorMessage(error: error.localizedDescription)
        }
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
