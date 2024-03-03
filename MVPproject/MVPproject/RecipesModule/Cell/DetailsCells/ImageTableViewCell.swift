// ImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с фото готового блюда
final class ImageTableViewCell: UITableViewCell {
    // MARK: - Constants

    static let reuseID = "ImageTableViewCell"

    enum Constants {
        static let cookingTime = "Cooking time"
        static let min = "min"
        static let gram = "g"
    }

    // MARK: - Visual components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.disableAutoresizingMask()
        label.font = .verdana(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.disableAutoresizingMask()
        imageView.layer.cornerRadius = 43
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()

    private let rightView: UIView = {
        let view = UIView()
        view.disableAutoresizingMask()
        view.backgroundColor = .greenAlpha
        view.layer.cornerRadius = 25
        return view
    }()

    private let rightViewLabel: UILabel = {
        let label = UILabel()
        label.disableAutoresizingMask()
        label.font = .verdana(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let rightImageView: UIImageView = {
        let imageView = UIImageView(image: .pot)
        imageView.disableAutoresizingMask()
        imageView.tintColor = .white
        return imageView
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.disableAutoresizingMask()
        view.backgroundColor = .greenAlpha
        view.layer.cornerRadius = 24
        return view
    }()

    private let bottomImageView: UIImageView = {
        let imageView = UIImageView(image: .timerPdf)
        imageView.disableAutoresizingMask()
        imageView.tintColor = .white
        return imageView
    }()

    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.disableAutoresizingMask()
        label.numberOfLines = 0
        label.font = .verdana(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    // MARK: - Initializators

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setTitleLabelConstraint()
        setImageViewConstraints()
        setRightViewConstraint()
        setRightImageViewConstraint()
        setRightLabelConstraint()
        setBottomViewConstraint()
        setBottomImageViewConsraint()
        setBottomLabelConstraint()
    }

    // MARK: - Public methods

    func configureCell(recipe: Recipe?) {
        guard let recipe = recipe else {
            return
        }
        titleImageView.image = UIImage(named: recipe.imageName)
        bottomLabel.text = "\(Constants.cookingTime)\n \(recipe.cookingTime) \(Constants.min)"
        rightViewLabel.text = "\(recipe.weight) \(Constants.gram)"
        titleLabel.text = recipe.name
    }

    // MARK: - Private methods

    private func setImageViewConstraints() {
        addSubview(titleImageView)
        titleImageView.widthAnchor.constraint(equalToConstant: 300).activate()
        titleImageView.heightAnchor.constraint(equalToConstant: 300).activate()
        titleImageView.centerXAnchor.constraint(equalTo: centerXAnchor).activate()
        titleImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).activate()
    }

    private func setRightViewConstraint() {
        titleImageView.addSubview(rightView)
        rightView.widthAnchor.constraint(equalToConstant: 50).activate()
        rightView.heightAnchor.constraint(equalToConstant: 50).activate()
        rightView.topAnchor.constraint(equalTo: titleImageView.topAnchor, constant: 8).activate()
        rightView.trailingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: -10).activate()
    }

    private func setTitleLabelConstraint() {
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).activate()
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).activate()
        titleLabel.topAnchor.constraint(equalTo: topAnchor).activate()
        titleLabel.heightAnchor.constraint(equalToConstant: 16).activate()
    }

    private func setRightImageViewConstraint() {
        addSubview(rightImageView)
        rightImageView.widthAnchor.constraint(equalToConstant: 20).activate()
        rightImageView.heightAnchor.constraint(equalToConstant: 17).activate()
        rightImageView.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).activate()
        rightImageView.topAnchor.constraint(equalTo: rightView.topAnchor, constant: 7).activate()
    }

    private func setRightLabelConstraint() {
        rightView.addSubview(rightViewLabel)
        rightViewLabel.widthAnchor.constraint(equalToConstant: 39).activate()
        rightViewLabel.heightAnchor.constraint(equalToConstant: 15).activate()
        rightViewLabel.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).activate()
        rightViewLabel.topAnchor.constraint(equalTo: rightImageView.bottomAnchor, constant: 6).activate()
    }

    private func setBottomViewConstraint() {
        titleImageView.addSubview(bottomView)
        bottomView.widthAnchor.constraint(equalToConstant: 154).activate()
        bottomView.heightAnchor.constraint(equalToConstant: 48).activate()
        bottomView.leadingAnchor.constraint(equalTo: titleImageView.leadingAnchor, constant: 176).activate()
        bottomView.bottomAnchor.constraint(equalTo: titleImageView.bottomAnchor).activate()
    }

    private func setBottomImageViewConsraint() {
        bottomView.addSubview(bottomImageView)
        bottomImageView.widthAnchor.constraint(equalToConstant: 25).activate()
        bottomImageView.heightAnchor.constraint(equalToConstant: 25).activate()
        bottomImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).activate()
        bottomImageView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 8).activate()
    }

    private func setBottomLabelConstraint() {
        bottomView.addSubview(bottomLabel)
        bottomLabel.widthAnchor.constraint(equalToConstant: 83).activate()
        bottomLabel.heightAnchor.constraint(equalToConstant: 30).activate()
        bottomLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).activate()
        bottomLabel.leadingAnchor.constraint(equalTo: bottomImageView.trailingAnchor).activate()
    }
}
