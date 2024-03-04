// EmptyPageMessageView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сообщение о том, что страница пуста
final class EmptyPageMessageView: UIStackView {
    // MARK: - Constants

    private enum Constants {
        static let iconSize = 50.0
        static let stackSpacing = 17.0
    }

    // MARK: - Visual Components

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.disableAutoresizingMask()
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.textColor = .grayTextSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializers

    init(icon: UIImage?, title: String, description: String) {
        super.init(frame: .zero)
        iconImageView.image = icon
        titleLabel.text = title
        descriptionLabel.text = description
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        disableAutoresizingMask()
        addArrangedSubview(iconImageView)
        addArrangedSubview(titleLabel)
        addArrangedSubview(descriptionLabel)
        axis = .vertical
        spacing = Constants.stackSpacing
        alignment = .center
    }
}
