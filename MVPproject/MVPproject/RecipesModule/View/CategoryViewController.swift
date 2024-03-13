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
    /// Скрыть сообщение пустой страницы
    func hideEmptyMessage()
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
        static let emptyPageTitle = "Nothing found"
        static let emptyPageDescription = "Try entering your query differently"
        static let emptyMessageToViewSpacing = 20.0
    }

    // MARK: - Visual Components

    private let emptyMessageView = EmptyPageMessageView(
        icon: .searchSquare,
        title: Constants.emptyPageTitle,
        description: Constants.emptyPageDescription
    )

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
        presenter?.screenLoaded()
    }

    // MARK: - Private methods

    private func setupView() {
        emptyMessageView.isHidden = true
        view.backgroundColor = .white
        view.addSubviews(tableView, searchBar, emptyMessageView)
        setupConstraints()
        setupEmptyMessageConstraints()
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

    private func setupEmptyMessageConstraints() {
        NSLayoutConstraint.activate([
            emptyMessageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            emptyMessageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.emptyMessageToViewSpacing
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: emptyMessageView.trailingAnchor,
                constant: Constants.emptyMessageToViewSpacing
            )
        ])
    }

    @objc private func closeCategory() {
        presenter?.closeCategory()
    }
}

// MARK: - CategoryViewController + CategoryViewProtocol

extension CategoryViewController: CategoryViewProtocol {
    func showEmptyMessage() {
        emptyMessageView.isHidden = false
    }

    func hideEmptyMessage() {
        emptyMessageView.isHidden = true
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
            cell.configure(withRecipe: recipe)
            return cell
        default:
            return .init()
        }
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
