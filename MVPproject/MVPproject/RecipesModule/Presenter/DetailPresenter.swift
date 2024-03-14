// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол для презентера детального экрана
protocol DetailPresenterProtocol: AnyObject {
    /// Mассив типов ячеек
    var cellTypes: [DetailCellType] { get }
    /// Рецепт
    var recipe: Recipe? { get set }
    /// Метод закрывает экран деталей
    func closeDetails()
    /// Экран загружен
    func screenLoaded()
    /// Пошарить рецепт
    func shareRecipe()
    /// Добавить рецепт в избранное
    func addFavoriteRecipe()
    /// Вью стейт
    var viewState: ViewState<Recipe> { get }
    /// Перезагрузка данных из сети
    func reloadData()
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

    var recipe: Recipe?
    private(set) var cellTypes: [DetailCellType] = [.image, .energy, .description]
    private let networkService: NetworkServiceProtocol
    private(set) var viewState: ViewState<Recipe> = .loading {
        didSet {
            updateDetailView()
        }
    }

    private weak var view: DetailViewProtocol?
    private weak var coordinator: RecipeWithDetailsCoordinatorProtocol?
    private var uri: String?

    // MARK: - Initializators

    init(
        view: DetailViewProtocol,
        coordinator: RecipeWithDetailsCoordinatorProtocol,
        networkService: NetworkServiceProtocol,
        recipe: Recipe
    ) {
        self.view = view
        self.coordinator = coordinator
        uri = recipe.uri
        self.networkService = networkService
        getDetails()
    }

    // MARK: - Private methods

    private func getDetails() {
        viewState = .loading
        guard let uri = uri else { return }
        networkService.getRecipesDetailsByURI(uri, completion: { [weak self] result in
            switch result {
            case let .success(data):
                self?.viewState = .data(data)
            case .failure(.emptyData):
                self?.viewState = .noData
            case let .failure(error):
                self?.viewState = .error(error)
            }
            self?.view?.reloadData()
        })
    }

    private func updateDetailView() {
        view?.hideMessage()
        view?.hideLoadingShimmer()
        switch viewState {
        case .loading:
            view?.showLoadingShimmer()
        case let .data(recipe):
            self.recipe = recipe
            view?.reloadData()
            view?.endRefresh()
        case .noData:
            view?.showEmptyMessage()
            view?.endRefresh()
        case .error:
            view?.showErrorMessage()
            view?.endRefresh()
        }
    }
}

// MARK: - DetailPresenter + DetailPresenterProtocol

extension DetailPresenter: DetailPresenterProtocol {
    func reloadData() {
        getDetails()
    }

    func addFavoriteRecipe() {
        guard let recipe = recipe else { return }
        FavoriteRecipes.shared.updateFavoriteRecipe(recipe)
    }

    func shareRecipe() {
        guard let recipe = recipe else { return }
        TxtFileLoggerInvoker.shared.log(.shareRecipe(recipe))
    }

    func screenLoaded() {
        guard let recipe = recipe else { return }
        TxtFileLoggerInvoker.shared.log(.viewScreen(ScreenInfo(title: "Recipe details")))
        TxtFileLoggerInvoker.shared.log(.openDetails(recipe))
    }

    func closeDetails() {
        coordinator?.closeDetails()
    }
}
