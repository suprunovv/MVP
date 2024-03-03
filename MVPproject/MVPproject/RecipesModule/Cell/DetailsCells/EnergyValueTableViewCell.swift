// EnergyValueTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с данными об энергетической ценности
final class EnergyValueTableViewCell: UITableViewCell {
    // MARK: - Constants

    static let reuseID = "EnergyValueTableViewCell"

    // MARK: - Visual components

    let caloriesView = EnergyView()
    let carbohydratesView = EnergyView()
    let fatsView = EnergyView()
    let proteinsView = EnergyView()

    private lazy var viewsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [caloriesView, carbohydratesView, fatsView, proteinsView])
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.disableAutoresizingMask()
        return stack
    }()

    // MARK: - Initializators

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setStackViewConstraint()
    }

    func setupCell(recipe: Recipe?) {
        guard let recipe = recipe else {
            return
        }
        caloriesView.setupView(type: .enerckcal, value: recipe.calories)
        carbohydratesView.setupView(type: .carbohydrates, value: 200)
        fatsView.setupView(type: .fats, value: 238)
        proteinsView.setupView(type: .proteins, value: 34)
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
