// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol CategoryViewProtocol: AnyObject {
    func setScreenTitle(_ title: String)
}

/// Вью экрана выбранной категории рецепта
final class CategoryViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseID)
        tableView.separatorStyle = .none
        tableView.disableAutoresizingMask()
        return tableView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 28)
        label.textColor = .black
        return label
    }()

    private lazy var backButton = UIBarButtonItem(
        image: .arrowBack,
        style: .plain,
        target: self,
        action: #selector(closeCategory)
    )

    // MARK: - Public properties

    var presenter: CategoryPresenterProtocol?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods

    private func setupView() {
        // TODO: Добавить кнопки с фильтрами как хедер таблицы
        // TODO: Добавить поиск как статический элемент вверху страницы
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func closeCategory() {
        presenter?.closeCategory()
    }
}

// MARK: - CategoryViewController + CategoryViewProtocol

extension CategoryViewController: CategoryViewProtocol {
    func setScreenTitle(_ title: String) {
        titleLabel.text = title
        let titleBarItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.setLeftBarButtonItems([backButton, titleBarItem], animated: false)
    }
}

// MARK: - CategoryViewController + UITableViewDataSource

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.recipes.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = presenter?.recipes[indexPath.row]
        guard let recipe = recipe,
              let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseID) as? RecipeCell
        else { return .init() }
        cell.configure(withRecipe: recipe)
        return cell
    }
}
