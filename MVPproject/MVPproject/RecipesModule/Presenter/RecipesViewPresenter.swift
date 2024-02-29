// RecipesViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// TODO: - Заприватить координатор (я попробовал, но под утро уже голова не варит :))

protocol RecipesPresenterProtocol: AnyObject {
    /// Проперти для установки координатора
    var recipesCoordinator: RecipesCoordinator? { get set }
    // TODO: - Придумать нормальное название методу
    func getModelViewToPresenter(recipesType: RecipesType)
}

/// Презентер для экрана с типами рецептов
class RecipesViewPresenter {
    private weak var view: RecipesViewProtocol?
    weak var recipesCoordinator: RecipesCoordinator?

    init(view: RecipesViewProtocol) {
        self.view = view
    }
}

// MARK: - RecipesViewPresenter + RecipesPresenterProtocol

extension RecipesViewPresenter: RecipesPresenterProtocol {
    func getModelViewToPresenter(recipesType: RecipesType) {
        // TODO: - Сюда придет модель c ячейки на которую мы нажали, ее будем передавать на следующий экран (Завтра обсудим)
        print(recipesType.name)
    }
}
