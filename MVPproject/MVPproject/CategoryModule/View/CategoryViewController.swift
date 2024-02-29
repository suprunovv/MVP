// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol CategoryViewProtocol: AnyObject {}

/// Вью экрана выбранной категории рецепта
final class CategoryViewController: UIViewController {
    // MARK: - Public properties

    var presenter: CategoryPresenterProtocol?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    // MARK: - Private methods

    private func setView() {
        view.backgroundColor = .white
    }
}

// MARK: - CategoryViewController + CategoryViewProtocol

extension CategoryViewController: CategoryViewProtocol {}
