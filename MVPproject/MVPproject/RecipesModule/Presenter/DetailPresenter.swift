// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол для презентера детального экрана
protocol DetailPresenterProtocol: AnyObject {
    /// Метод поучает модель рецепта
    func getRecipe() -> Recipe
    /// Mассив типов ячеек
    var cellTypes: [DetailCellType] { get }
    /// Метод закрывает экран деталей
    func closeDetails()
}

/// Протокол для вью детального экрана
protocol DetailViewProtocol: AnyObject {}

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
    private weak var coordinator: RecipesCoordinator?
    private var recipe: Recipe

    // MARK: - Initializators

    init(view: DetailViewProtocol, coordinator: RecipesCoordinator, recipe: Recipe) {
        self.view = view
        self.coordinator = coordinator
        self.recipe = recipe
    }
}

// MARK: - DetailPresenter + DetailPresenterProtocol

extension DetailPresenter: DetailPresenterProtocol {
    func closeDetails() {
        coordinator?.goBack()
    }

    func getRecipe() -> Recipe {
        recipe
    }
}
