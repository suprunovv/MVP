// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол представления Избранное
protocol FavoritesViewProtocol: AnyObject {}

/// Избранное
final class FavoritesViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let title = "Favorites"
    }

    // MARK: - Visual Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseID)
        tableView.separatorStyle = .none
        tableView.disableAutoresizingMask()
        return tableView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Properties
    var presenter: FavoritesPresenterProtocol?

    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
        setupNavigationItem()
    }

    private func setupNavigationItem() {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 28)
        label.textColor = .black
        label.text = Constants.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - FavoritesViewController + UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.favoriteRecipes.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = presenter?.favoriteRecipes[indexPath.row]
        guard let recipe = recipe,
              let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseID) as? RecipeCell
        else { return .init() }
        cell.configure(withRecipe: recipe)
        return cell
    }
}

// MARK: - FavoritesViewController + UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = presenter?.favoriteRecipes[indexPath.row] else { return }
        presenter?.showRecipeDetails(recipe: recipe)
    }
}

// MARK: - FavoritesViewController + FavoritesViewProtocol

extension FavoritesViewController: FavoritesViewProtocol {}
