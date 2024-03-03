// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью экрана с детальным описанием рецепта
final class DetailViewController: UIViewController {
    // MARK: - Visual components

    private let detailsTabelView = UITableView()

    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.paperplane, for: .normal)
        button.tintColor = .black
        return button
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.bookmarkBarIcon, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(addFavorites), for: .touchUpInside)
        return button
    }()

    private lazy var backButton = UIBarButtonItem(
        image: .arrowBack,
        style: .plain,
        target: self,
        action: #selector(closeDetail)
    )

    // MARK: - Public properties

    var presenter: DetailPresenterProtocol?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods

    private func setupView() {
        view.backgroundColor = .white
        setTabelViewConstraints()
        setupDetailsTabelView()
        setNavigationBar()
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
        detailsTabelView.delegate = self
        detailsTabelView.dataSource = self
    }

    @objc private func closeDetail() {
        presenter?.closeDetails()
    }

    @objc private func addFavorites() {
        print("Добавлено в избранное")
    }
}

// MARK: - DetailViewController + DetailViewProtocol

extension DetailViewController: DetailViewProtocol {}

// MARK: - DetailViewController + UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cells = presenter?.getCellTypes() else { return 0 }
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = presenter?.getCellTypes()
        guard let cells = cells else { return UITableViewCell() }
        switch cells[indexPath.row] {
        case .image:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ImageTableViewCell.reuseID,
                for: indexPath
            ) as? ImageTableViewCell else { return UITableViewCell() }
            cell.configureCell(recipe: presenter?.getRecipe())
            return cell
        case .energy:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: EnergyValueTableViewCell.reuseID,
                for: indexPath
            ) as? EnergyValueTableViewCell else { return UITableViewCell() }
            cell.setupCell(recipe: presenter?.getRecipe())
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FullRecipeTableViewCell.reuseID,
                for: indexPath
            ) as? FullRecipeTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
}

// MARK: - DetailViewController + UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = presenter?.getCellTypes()[indexPath.row]
        guard let cell = cell else { return 0 }
        switch cell {
        case .image:
            return 336
        case .energy:
            return 93
        case .description:
            return UITableView.automaticDimension
        }
    }
}
