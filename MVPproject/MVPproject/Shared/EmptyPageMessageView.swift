// EmptyPageMessageView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол делегата пустой страницы
protocol EmptyMessageViewDelegate: AnyObject {
    /// Метод перезагрузки
    func reload()
}

/// Сообщение о том, что страница пуста
final class EmptyPageMessageView: UIStackView {
    // MARK: - Constants

    private enum Constants {
        static let iconSize = 50.0
        static let stackSpacing = 17.0
        static let reloadButtonCornerRadius = 12.0
        static let reloadButtonSize = CGSize(width: 150, height: 32)
        static let reloadButtonText = "Reload"
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

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.textColor = .grayTextSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Constants.reloadButtonCornerRadius
        button.setImage(.reload, for: .normal)
        button.backgroundColor = .blueLight
        button.setTitle(Constants.reloadButtonText, for: .normal)
        button.titleLabel?.font = .verdana(ofSize: 14)
        button.titleLabel?.textColor = .grayTextSecondary
        button.tintColor = .grayTextSecondary
        button.disableAutoresizingMask()
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: Constants.reloadButtonSize.width),
            button.heightAnchor.constraint(equalToConstant: Constants.reloadButtonSize.height)
        ])
        button.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    weak var delegate: EmptyMessageViewDelegate?

    // MARK: - Initializers

    init(icon: UIImage?, title: String? = nil, description: String, withReload: Bool = false) {
        super.init(frame: .zero)
        setupView()
        configureUI(icon: icon, title: title, description: description, withReload: withReload)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Public Methods

    func updateUI(icon: UIImage?, title: String? = nil, description: String, withReload: Bool = false) {
        configureUI(icon: icon, title: title, description: description, withReload: withReload)
    }

    // MARK: - Private Methods

    private func setupView() {
        disableAutoresizingMask()
        addArrangedSubview(iconImageView)
        addArrangedSubview(titleLabel)
        addArrangedSubview(descriptionLabel)

        addArrangedSubview(reloadButton)
        axis = .vertical
        spacing = Constants.stackSpacing
        alignment = .center
    }

    private func configureUI(icon: UIImage?, title: String? = nil, description: String, withReload: Bool = false) {
        iconImageView.image = icon
        descriptionLabel.text = description
        titleLabel.text = title
        titleLabel.isHidden = title == nil
        reloadButton.isHidden = !withReload
    }

    @objc private func reloadButtonTapped() {
        delegate?.reload()
    }
}
