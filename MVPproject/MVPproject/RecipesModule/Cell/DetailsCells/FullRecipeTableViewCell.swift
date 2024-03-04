// FullRecipeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с полным описанием готовки блюда
final class FullRecipeTableViewCell: UITableViewCell {
    // MARK: - Constants

    static let reuseID = String(describing: FullRecipeTableViewCell.self)

    // MARK: - Visual components

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.textColor = .black
        label.disableAutoresizingMask()
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializators

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLabelConstraints()
        setCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public methods

    func setupDescription(text: String?) {
        guard let text = text else {
            return
        }
        descriptionLabel.text = text
    }

    // MARK: - Private methods

    private func setLabelConstraints() {
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27).activate()
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27).activate()
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).activate()
    }

    private func setCell() {
        heightAnchor.constraint(equalTo: descriptionLabel.heightAnchor, constant: 20).activate()
        backgroundColor = .blueRecipeBg
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = 24
    }
}
