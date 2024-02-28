// BonusesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Бонусы
final class BonusesViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let bonusesLabelText = "Your bonuses"
        static let bonusesImageWidth = 150.0
        static let starToBonusesCountSpacing = 11.0
        static let bonusesLabelToImageSpacing = 13.0
        static let bonusesCountToImageSpacing = 27.0
    }

    // MARK: - Visual Components
    private let bonusesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.bonusesLabelText
        label.font = .verdanaBold(ofSize: 20)
        label.textColor = .grayText
        return label
    }()

    private let bonusesImageView: UIImageView = {
        let imageView = UIImageView(image: .bonuses)
        imageView.disableAutoresizingMask()
        imageView.widthAnchor.constraint(equalToConstant: Constants.bonusesImageWidth).activate()
        return imageView
    }()

    private let bonusesCountLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = .verdanaBold(ofSize: 30)
        label.textColor = .grayText
        return label
    }()

    private lazy var bonusesCountStackView: UIStackView = {
        let starImageView = UIImageView(image: .yellowStar)
        let stack = UIStackView(arrangedSubviews: [starImageView, bonusesCountLabel])
        stack.spacing = Constants.starToBonusesCountSpacing
        stack.alignment = .center
        return stack
    }()

    private lazy var bonusesStackView: UIStackView = {
        let topStack = UIStackView(arrangedSubviews: [bonusesTitleLabel, bonusesImageView])
        topStack.axis = .vertical
        topStack.spacing = Constants.bonusesLabelToImageSpacing
        topStack.alignment = .center
        let stack = UIStackView(arrangedSubviews: [topStack, bonusesCountStackView])
        stack.axis = .vertical
        stack.spacing = Constants.bonusesCountToImageSpacing
        stack.alignment = .center
        stack.disableAutoresizingMask()
        return stack
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods
    private func setupView() {
        view.addSubview(bonusesStackView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bonusesStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bonusesStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
