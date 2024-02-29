// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RecipesViewProtocol: AnyObject {
    func updateRecipes(categories: [RecipesCategory])
}

/// Вью экрана с типами рецептов
final class RecipesViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let titleText = "Recipes"
        static let minimumLineSpacing: CGFloat = 15
        static let minimumInteritemSpacing: CGFloat = 10
    }

    // MARK: - Public properties

    var presenter: RecipesPresenterProtocol?

    // MARK: - Private properties

    private var typeDishCollectionView: UICollectionView!

    // MARK: - Moke Data

    private var recipesCategories: [RecipesCategory] = []

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }

    // MARK: - Private methods

    private func setViews() {
        view.backgroundColor = .white
        setupDishCollection()
        setTitle()
        presenter?.getRecipesCategory()
    }

    private func setTitle() {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 28)
        label.textColor = .black
        label.text = Constants.titleText

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }

    private func makeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        return layout
    }

    private func setupDishCollection() {
        typeDishCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeFlowLayout()
        )
        typeDishCollectionView.register(
            RecipesCategoryCell.self,
            forCellWithReuseIdentifier: RecipesCategoryCell.reuseID
        )
        typeDishCollectionView.delegate = self
        typeDishCollectionView.dataSource = self
        view.addSubview(typeDishCollectionView)
        typeDishCollectionView.disableAutoresizingMask()
        NSLayoutConstraint.activate([
            typeDishCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            typeDishCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            typeDishCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            typeDishCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - RecipesViewController + UICollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipesCategories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipesCategoryCell.reuseID,
            for: indexPath
        ) as? RecipesCategoryCell else { return UICollectionViewCell() }
        cell.setupCell(category: recipesCategories[indexPath.item])
        return cell
    }
}

// MARK: - RecipesViewController + UICollectionViewDelegate

extension RecipesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showRecipesByCategory(category: recipesCategories[indexPath.item])
    }
}

// MARK: - RecipesViewController + UICollectionViewDelegateFlowLayout

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch recipesCategories[indexPath.item].cellType {
        case .middle:
            return CGSize(
                width: view.bounds.width / 2 - 22,
                height: view.bounds.width / 2 - 22
            )
        case .big:
            return CGSize(
                width: view.bounds.width - 140,
                height: view.bounds.width - 140
            )
        case .smal:
            return CGSize(
                width: view.bounds.width / 3 - 18,
                height: view.bounds.width / 3 - 18
            )
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - RecipesViewController + RecipesViewProtocol

extension RecipesViewController: RecipesViewProtocol {
    func updateRecipes(categories: [RecipesCategory]) {
        recipesCategories = categories
    }
}
