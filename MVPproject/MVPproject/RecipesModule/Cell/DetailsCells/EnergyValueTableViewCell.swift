// EnergyValueTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с данными об энергетической ценности
final class EnergyValueTableViewCell: UITableViewCell {
    // MARK: - Constants

    static let reuseID = String(describing: EnergyValueTableViewCell.self)

    // MARK: - Visual components

    private let caloriesView = EnergyView()
    private let carbohydratesView = EnergyView()
    private let fatsView = EnergyView()
    private let proteinsView = EnergyView()

    private lazy var viewsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [caloriesView, carbohydratesView, fatsView, proteinsView])
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.disableAutoresizingMask()
        return stack
    }()

    // MARK: - Initializators

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStackViewConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public methods

    func setupCell(recipe: Recipe?) {
        guard let recipe = recipe else { return }
        caloriesView.setupView(type: .enerckcal, value: recipe.calories)
        carbohydratesView.setupView(type: .carbohydrates, value: recipe.details?.carbohydrates ?? 0)
        fatsView.setupView(type: .fats, value: recipe.details?.fats ?? 0)
        proteinsView.setupView(type: .proteins, value: recipe.details?.proteins ?? 0)
    }

    // MARK: - Private methods

    private func setStackViewConstraint() {
        addSubview(viewsStackView)
        viewsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).activate()
        viewsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).activate()
        viewsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).activate()
        viewsStackView.heightAnchor.constraint(equalToConstant: 53).activate()
    }
}
