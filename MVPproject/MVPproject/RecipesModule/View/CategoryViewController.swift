// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол представления категории рецептов
protocol CategoryViewProtocol: AnyObject {
    /// Метод установки заголовка экрана
    func setScreenTitle(_ title: String)
    /// Метод обновляющий таблицу с рецептами
    func reloadRecipeTable()
    /// Показать сообщение пустой страницы
    func showEmptyMessage()
    /// Показать сообщение об ошибке
    func showErrorMessage()
    /// Показать сообщение, что ничего не найдено
    func showNotFoundMessage()
    /// Скрыть плашку-сообщение
    func hideMessage()
    /// завершение pull to refresh
    func endRefresh()
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
        static let notFoundTitle = "Nothing found"
        static let notFoundDescription = "Try entering your query differently"
        static let errorMessageDescription = "Failed to load data"
        static let emptyPageDescription = "Start typing text"
        static let emptyMessageToViewSpacing = 20.0
    }

    // MARK: - Visual Components

    private let messageView = MessageView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 28)
        label.textColor = .black
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseID)
        tableView.register(RecipeShimmeredCell.self, forCellReuseIdentifier: RecipeShimmeredCell.reuseID)
        tableView.separatorStyle = .none
        tableView.disableAutoresizingMask()
        return tableView
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
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

    private lazy var sortButtonsView: UIView = SortButtonsView()

    private lazy var backButton = UIBarButtonItem(
        image: .arrowBack,
        style: .plain,
        target: self,
        action: #selector(closeCategory)
    )

    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        return refresh
    }()

    // MARK: - Public properties

    var presenter: CategoryPresenterProtocol?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.screenLoaded()
    }

    // MARK: - Private methods

    private func setupView() {
        messageView.isHidden = true
        view.backgroundColor = .white
        view.addSubviews(tableView, searchBar, messageView, sortButtonsView)
        setupConstraints()
        setupEmptyMessageConstraints()
        tableView.refreshControl = refreshControl
    }

    private func setupConstraints() {
        tableView.setContentHuggingPriority(.defaultLow, for: .vertical)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sortButtonsView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: Constants.searchBarToTableSpacing
            ),
            sortButtonsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sortButtonsView.heightAnchor.constraint(equalToConstant: 36),

            tableView.topAnchor.constraint(
                equalTo: sortButtonsView.bottomAnchor,
                constant: Constants.searchBarToTableSpacing
            ),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupEmptyMessageConstraints() {
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: sortButtonsView.bottomAnchor),
            messageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.emptyMessageToViewSpacing
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: messageView.trailingAnchor,
                constant: Constants.emptyMessageToViewSpacing
            )
        ])
    }

    @objc private func closeCategory() {
        presenter?.closeCategory()
    }

    @objc private func refreshData(_ sender: UIRefreshControl) {
        presenter?.reloadData()
    }
}

// MARK: - CategoryViewController + CategoryViewProtocol

extension CategoryViewController: CategoryViewProtocol {
    func endRefresh() {
        refreshControl.endRefreshing()
    }

    func showErrorMessage() {
        messageView.updateUI(
            icon: .boltSquare,
            title: nil,
            description: Constants.errorMessageDescription,
            withReload: true
        )
        messageView.isHidden = false
    }

    func showNotFoundMessage() {
        messageView.updateUI(
            icon: .searchSquare,
            title: Constants.notFoundTitle,
            description: Constants.notFoundDescription
        )
        messageView.isHidden = false
    }

    func showEmptyMessage() {
        messageView.updateUI(
            icon: .searchSquare,
            title: nil,
            description: Constants.emptyPageDescription
        )
        messageView.isHidden = false
    }

    func hideMessage() {
        messageView.isHidden = true
    }

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
        switch presenter?.viewState {
        case .loading:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: RecipeShimmeredCell.reuseID) as? RecipeShimmeredCell
            else { return .init() }
            tableView.isScrollEnabled = false
            tableView.allowsSelection = false
            return cell
        case let .data(recipes):
            let recipe = recipes[indexPath.row]
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: RecipeCell.reuseID) as? RecipeCell
            else { return .init() }
            tableView.isScrollEnabled = true
            tableView.allowsSelection = true
            presenter?.loadImage(url: recipe.imageURL, completion: { imageData in
                cell.setImage(imageData)
            })
            cell.configure(withRecipe: recipe)
            return cell
        default:
            return .init()
        }
    }
}

// MARK: - CategoryViewController + UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = presenter?.recipes[indexPath.row] else { return }
        presenter?.showRecipeDetails(recipe: recipe)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
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

// MARK: - CategoryViewController + UISearchBarDelegate

extension CategoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.updateSearchTerm(searchText)
    }
}
