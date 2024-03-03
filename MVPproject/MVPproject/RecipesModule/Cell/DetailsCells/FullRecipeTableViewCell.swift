// FullRecipeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с полным описанием готовки блюда
final class FullRecipeTableViewCell: UITableViewCell {
    // MARK: - Constants

    static let reuseID = "FullRecipeTableViewCell"

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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setLabelConstraints()
        setText()
        setCell()
        heightAnchor.constraint(equalTo: descriptionLabel.heightAnchor, constant: 20).activate()
    }

    // MARK: - Private methods

    private func setLabelConstraints() {
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27).activate()
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27).activate()
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).activate()
    }

    private func setCell() {
        backgroundColor = .fullRecipeColor
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = 24
    }

    // MARK: - ЭТОГО ТУТ ПОНЯТНОЕ ДЕЛО НЕ БУДЕТ НИКОГДА, Временно что бы отображалось, Потом будет добавлятся в методе setupCell, а пока что текст один для всего

    private func setText() {
        descriptionLabel.text = """
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes
        1/2 to 2 fish heads, depending on size, about 5 pounds total
        2 tablespoons vegetable oil
        1/4 cup red or green thai curry paste
        3 tablespoons fish sauce or anchovy sauce
        1 tablespoon sugar
        1 can coconut milk, about 12 ounces
        3 medium size asian eggplants, cut int 1 inch rounds
        Handful of bird's eye chilies
        1/2 cup thai basil leaves
        Juice of 3 limes

        """
    }
}
