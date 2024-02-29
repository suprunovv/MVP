// TypeRecipesCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячека типа рецепта
class TypeRecipesCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    static let reuseID = "TypeRecipesCollectionViewCell"

    // MARK: - Visual Components

    private let titleImageView = UIImageView()

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.7
        return view
    }()

    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializators

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public methods

    func setupCell(type: RecipesType) {
        bottomLabel.text = type.name
        titleImageView.image = UIImage(named: type.imageName)
    }

    // MARK: - Private methods

    private func setViews() {
        layer.cornerRadius = 18
        clipsToBounds = true
        setTitleImageViewConstaints()
        setBottomViewConstaints()
        setBottomLabelConstaints()
        // TODO: - Тень надо доделать
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 3
    }

    private func setTitleImageViewConstaints() {
        addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: topAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    private func setBottomViewConstaints() {
        addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    private func setBottomLabelConstaints() {
        addSubview(bottomLabel)
        NSLayoutConstraint.activate([
            bottomLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
        ])
    }
}
