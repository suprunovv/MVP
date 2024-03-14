// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для вью детального экрана
protocol DetailViewProtocol: AnyObject {
    /// Перезагрузка таблицы
    func reloadData()
    /// Показать сообщение об отсутствии данных
    func showEmptyMessage()
    /// Скрыть сообщение об отсутствии данных
    func hideEmptyMessage()
    /// Показать вью с ошибкой
    func showErrorMessage(error: String)
    /// Завершить pull to refresh
    func endingRefresh()
}

/// Вью экрана с детальным описанием рецепта
final class DetailViewController: UIViewController {
    private enum Constants {
        static let emptyPageTitle = "Nothing found"
        static let emptyPageDescription = "Try entering your query differently"
    }

    // MARK: - Visual components

    private let detailsTabelView = UITableView()

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

    private let emptyMessageView = EmptyPageMessageView(
        icon: .searchSquare,
        title: Constants.emptyPageTitle,
        description: Constants.emptyPageDescription
    )

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
        setTabelViewConstraints()
        setupDetailsTabelView()
        setNavigationBar()
        setupEmptyMessageConstraints()
        detailsTabelView.refreshControl = refreshControl
    }

    private func setupEmptyMessageConstraints() {
        view.addSubview(emptyMessageView)
        NSLayoutConstraint.activate([
            emptyMessageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            emptyMessageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: emptyMessageView.trailingAnchor,
                constant: 20
            )
        ])
    }

    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = backButton
        let shareItem = UIBarButtonItem(customView: shareButton)
        let favoriteItem = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItems = [favoriteItem, shareItem]
    }

    private func setTabelViewConstraints() {
        view.addSubview(detailsTabelView)
        detailsTabelView.disableAutoresizingMask()
        NSLayoutConstraint.activate([
            detailsTabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsTabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailsTabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailsTabelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupDetailsTabelView() {
        detailsTabelView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseID)
        detailsTabelView.register(
            EnergyValueTableViewCell.self,
            forCellReuseIdentifier: EnergyValueTableViewCell.reuseID
        )
        detailsTabelView.register(FullRecipeTableViewCell.self, forCellReuseIdentifier: FullRecipeTableViewCell.reuseID)
        detailsTabelView.rowHeight = UITableView.automaticDimension
        detailsTabelView.allowsSelection = false
        detailsTabelView.separatorStyle = .none
        detailsTabelView.dataSource = self
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
    func endingRefresh() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }

    func showErrorMessage(error: String) {
        print(error)
    }

    func hideEmptyMessage() {
        DispatchQueue.main.async { [weak self] in
            self?.emptyMessageView.isHidden = true
        }
    }

    func showEmptyMessage() {
        emptyMessageView.isHidden = false
    }

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.detailsTabelView.reloadData()
        }
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
            cell.configureCell(recipe: presenter?.getDetailsRecipe())
            return cell
        case .energy:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: EnergyValueTableViewCell.reuseID,
                for: indexPath
            ) as? EnergyValueTableViewCell else { return UITableViewCell() }
            cell.setupCell(recipe: presenter?.getDetailsRecipe())
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FullRecipeTableViewCell.reuseID,
                for: indexPath
            ) as? FullRecipeTableViewCell else { return UITableViewCell() }
            cell.setupDescription(text: presenter?.getDetailsRecipe().details?.ingredientLines)
            return cell
        }
    }
}
