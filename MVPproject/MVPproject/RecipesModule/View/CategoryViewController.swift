// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол представления категории рецептов
protocol CategoryViewProtocol: AnyObject {
    /// Метод установки заголовка экрана
    func setScreenTitle(_ title: String)
    /// Метод обновляющий таблицу с рецептами
    func reloadRecipeTable()
}

/// Вью экрана выбранной категории рецепта
final class CategoryViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let searchBarPlaceholder = "Search recipes"
        static let searchBarToTableSpacing = 12.0
        static let sortingHeight = 36.0
        static let sortingToViewSpacing = 20.0
        static let searchBarInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        static let sortingHeaderHeight = 20.0
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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 28)
        label.textColor = .black
        return label
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.searchBarPlaceholder,
            attributes: [
                .font: UIFont.verdana(ofSize: 16) ?? UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.grayTextPlaceholder
            ]
        )
        searchBar.searchBarStyle = .minimal
        searchBar.layoutMargins = Constants.searchBarInsets
        searchBar.disableAutoresizingMask()
        return searchBar
    }()

    private lazy var sortButtonsView: UIView = {
        let containerView = UIView()
        let view = SortButtonsView()
        view.delegate = self
        containerView.disableAutoresizingMask()
        view.disableAutoresizingMask()
        containerView.addSubview(view)
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: Constants.sortingHeight),
            view.topAnchor.constraint(equalTo: containerView.topAnchor),
            view.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Constants.sortingToViewSpacing
            ),
            containerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.sortingToViewSpacing
            ),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return containerView
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
        view.backgroundColor = .white
        view.addSubviews(tableView, searchBar)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: Constants.searchBarToTableSpacing
            ),
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
    func reloadRecipeTable() {
        tableView.reloadData()
    }

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
              let cell = tableView
              .dequeueReusableCell(withIdentifier: RecipeCell.reuseID) as? RecipeCell
        else { return .init() }
        switch presenter?.loadingState {
        case .initial, .loading:
            tableView.isScrollEnabled = false
            cell.maskWithShimmer()
        case .loaded:
            tableView.isScrollEnabled = true
            cell.configure(withRecipe: recipe)
        default:
            break
        }

        return cell
    }
}

// MARK: - CategoryViewController + UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.sortingHeaderHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        sortButtonsView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = presenter?.recipes[indexPath.row] else { return }
        presenter?.showRecipeDetails(recipe: recipe)
    }
}

// MARK: - CategoryViewController + SortButtonViewDelegate

extension CategoryViewController: SortButtonViewDelegate {
    func updateTimeSorting(_ sorting: SortingButton.SortState) {
        presenter?.stateByTime(state: sorting)
    }

    func updateCaloriesSorting(_ sorting: SortingButton.SortState) {
        presenter?.stateByCalories(state: sorting)
    }
}
