// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для вью детального экрана
protocol DetailViewProtocol: AnyObject {
    /// Перезагрузка таблицы
    func reloadData()
    /// Показать сообщение об отсутствии данных
    func showEmptyMessage()
    /// Скрыть плашку-сообщени
    func hideMessage()
    /// Показать вью с ошибкой
    func showErrorMessage()
    /// Завершить pull to refresh
    func endRefresh()
    /// Показать индикатор загрузки
    func showLoadingShimmer()
    /// Спрятать индикатор загрузки
    func hideLoadingShimmer()
}

/// Вью экрана с детальным описанием рецепта
final class DetailViewController: UIViewController {
    private enum Constants {
        static let emptyDataTitle = "Nothing found"
        static let emptyDataDescription = "Try reloading the page"
        static let errorMessageDescription = "Failed to load data"
    }

    // MARK: - Visual components

    private let detailsTableView = UITableView()
    private let detailsShimmerView: DetailsShimmerView = {
        let shimmerView = DetailsShimmerView()
        shimmerView.isHidden = true
        return shimmerView
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.paperplane, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.bookmarkBarIcon, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(addFavorites), for: .touchUpInside)
        return button
    }()

    private let messageView = MessageView()

    private lazy var backButton = UIBarButtonItem(
        image: .arrowBack,
        style: .plain,
        target: self,
        action: #selector(closeDetail)
    )

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Public properties

    var presenter: DetailPresenterProtocol?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.screenLoaded()
    }

    // MARK: - Private methods

    private func setupView() {
        view.backgroundColor = .white
        setTableViewConstraints()
        setupDetailsTabelView()
        setNavigationBar()
        setupEmptyMessageConstraints()
        setupShimmerViewConstraints()
        detailsTableView.refreshControl = refreshControl
    }

    private func setupShimmerViewConstraints() {
        view.addSubview(detailsShimmerView)
        NSLayoutConstraint.activate([
            detailsShimmerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsShimmerView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: detailsShimmerView.trailingAnchor
            ),
            detailsShimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupEmptyMessageConstraints() {
        view.addSubview(messageView)
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: messageView.trailingAnchor
            )
        ])
    }

    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = backButton
        let shareItem = UIBarButtonItem(customView: shareButton)
        let favoriteItem = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItems = [favoriteItem, shareItem]
    }

    private func setTableViewConstraints() {
        view.addSubview(detailsTableView)
        detailsTableView.disableAutoresizingMask()
        NSLayoutConstraint.activate([
            detailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupDetailsTabelView() {
        detailsTableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseID)
        detailsTableView.register(
            EnergyValueTableViewCell.self,
            forCellReuseIdentifier: EnergyValueTableViewCell.reuseID
        )
        detailsTableView.register(FullRecipeTableViewCell.self, forCellReuseIdentifier: FullRecipeTableViewCell.reuseID)
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.allowsSelection = false
        detailsTableView.separatorStyle = .none
        detailsTableView.dataSource = self
    }

    @objc private func closeDetail() {
        presenter?.closeDetails()
    }

    @objc private func addFavorites() {
        presenter?.addFavoriteRecipe()
        FavoriteRecipes.shared.encodeRecipes()
    }

    @objc private func shareButtonTapped() {
        presenter?.shareRecipe()
    }

    @objc private func refreshData() {
        presenter?.reloadData()
    }
}

// MARK: - DetailViewController + DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func showLoadingShimmer() {
        detailsShimmerView.isHidden = false
        detailsTableView.isHidden = true
    }

    func hideLoadingShimmer() {
        detailsShimmerView.isHidden = true
        detailsTableView.isHidden = false
    }

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

    func hideMessage() {
        messageView.isHidden = true
    }

    func showEmptyMessage() {
        messageView.updateUI(
            icon: .searchSquare,
            title: Constants.emptyDataTitle,
            description: Constants.emptyDataDescription,
            withReload: true
        )
        messageView.isHidden = false
    }

    func reloadData() {
        detailsTableView.reloadData()
    }
}

// MARK: - DetailViewController + UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.cellTypes.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = presenter?.cellTypes
        guard let cells = cells else { return UITableViewCell() }
        switch cells[indexPath.row] {
        case .image:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ImageTableViewCell.reuseID,
                for: indexPath
            ) as? ImageTableViewCell else { return UITableViewCell() }
            cell.configureCell(recipe: presenter?.recipe)
            return cell
        case .energy:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: EnergyValueTableViewCell.reuseID,
                for: indexPath
            ) as? EnergyValueTableViewCell else { return UITableViewCell() }
            cell.setupCell(recipe: presenter?.recipe)
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FullRecipeTableViewCell.reuseID,
                for: indexPath
            ) as? FullRecipeTableViewCell else { return UITableViewCell() }
            cell.setupDescription(text: presenter?.recipe?.details?.ingredientLines)
            return cell
        }
    }
}
