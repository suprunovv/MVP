// RecipeCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка рецепта
class RecipeCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let panelCornerRadius = 12.0
        static let recipeImageCornerRadius = 12.0
        static let infoIconSize = 15.0
        static let recipeImageSize = 80.0
        static let chevronSize = 20.0
        static let recipeStackSpacing = 20.0
        static let infoIconToLabelSpacing = 4.0
        static let infoSpacing = 20.0
        static let infoStackHeight = 56.0
        static let cellInnerSpacing = 10.0
        static let cellOuterSpacing = (x: 20.0, y: 7.0)
        static let timeInfoText = "min"
        static let caloriesInfoText = "kkal"
        static let recipeNameLabelSize = CGSize(width: 197, height: 32)
        static let cookingTimeSize = CGSize(width: 74, height: 15)
        static let caloriesSize = CGSize(width: 91, height: 15)
    }

    static var reuseID: String { String(describing: RecipeCell.self) }

    // MARK: - Visual Components

    private(set) var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.recipeImageCornerRadius
        imageView.clipsToBounds = true
        imageView.disableAutoresizingMask()
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.recipeImageSize),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        return imageView
    }()

    private(set) var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.numberOfLines = 0
        label.disableAutoresizingMask()
        return label
    }()

    private(set) var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: .chevronBold)
        imageView.contentMode = .center
        imageView.disableAutoresizingMask()
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.chevronSize),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        return imageView
    }()

    private let recipeView: UIView = {
        let view = UIView()
        view.backgroundColor = .greenBgAccent
        view.layer.cornerRadius = Constants.panelCornerRadius
        view.disableAutoresizingMask()
        return view
    }()

    private let cookingTimeLabel = UILabel()
    private let caloriesLabel = UILabel()

    private(set) lazy var cookingTimeStackView = makeInfoStack(label: cookingTimeLabel, image: .timer)
    private(set) lazy var caloriesStackView = makeInfoStack(label: caloriesLabel, image: .pizza)

    private lazy var infoStackView: UIStackView = {
        let infoStack = UIStackView(arrangedSubviews: [cookingTimeStackView, caloriesStackView])
        infoStack.spacing = Constants.infoSpacing
        infoStack.alignment = .leading
        let stack = UIStackView(arrangedSubviews: [recipeNameLabel, infoStack])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.disableAutoresizingMask()
        stack.heightAnchor.constraint(equalToConstant: Constants.infoStackHeight).activate()
        return stack
    }()

    private lazy var recipeStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [recipeImageView, infoStackView, chevronImageView])
        stack.spacing = Constants.recipeStackSpacing
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.disableAutoresizingMask()
        return stack
    }()

    private var isMaskedWithShimmer = false {
        didSet {
            updateLayout()
        }
    }

    private lazy var shimmeredViews = [recipeImageView, cookingTimeStackView, caloriesStackView, recipeNameLabel]
    private lazy var shimmerConstraints = [
        recipeNameLabel.widthAnchor.constraint(equalToConstant: Constants.recipeNameLabelSize.width),
        recipeNameLabel.heightAnchor.constraint(equalToConstant: Constants.recipeNameLabelSize.height),

        cookingTimeStackView.widthAnchor.constraint(equalToConstant: Constants.cookingTimeSize.width),
        cookingTimeStackView.heightAnchor.constraint(equalToConstant: Constants.cookingTimeSize.height),

        caloriesStackView.widthAnchor.constraint(equalToConstant: Constants.caloriesSize.width),
        caloriesStackView.heightAnchor.constraint(equalToConstant: Constants.caloriesSize.height)
    ]
    private var shimmerLayersMap: [String: ShimmerLayer] = [:]

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    // MARK: - Public Methods

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isMaskedWithShimmer {
            for item in [recipeImageView, cookingTimeStackView, caloriesStackView, recipeNameLabel] {
                addShimmerLayer(view: item)
            }
        }
    }

    func configure(withRecipe recipe: Recipe) {
        isMaskedWithShimmer = false
        recipeImageView.image = UIImage(named: recipe.imageName)
        recipeNameLabel.text = recipe.name
        cookingTimeLabel.text = "\(recipe.cookingTime) \(Constants.timeInfoText)"
        caloriesLabel.text = "\(recipe.calories) \(Constants.caloriesInfoText)"
    }

    func maskWithShimmer() {
        isMaskedWithShimmer = true
    }

    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        recipeView.addSubview(recipeStackView)
        contentView.addSubview(recipeView)
        setupConstraints()
    }

    private func updateLayout() {
        if isMaskedWithShimmer {
            NSLayoutConstraint.activate(shimmerConstraints)
            shimmeredViews.forEach { addShimmerLayer(view: $0) }
            chevronImageView.isHidden = true
        } else {
            NSLayoutConstraint.deactivate(shimmerConstraints)
            shimmeredViews.forEach { removeShimmerLayer(view: $0) }
            chevronImageView.isHidden = false
        }
    }

    private func addShimmerLayer(view: UIView) {
        let viewStringKey = String(describing: view)
        if shimmerLayersMap[viewStringKey] != nil || view.bounds.size == .zero { return }
        let shimmerLayer = ShimmerLayer(clearColor: .greenBgAccent)
        shimmerLayer.frame = view.bounds
        view.layer.addSublayer(shimmerLayer)
        shimmerLayersMap[viewStringKey] = shimmerLayer
    }

    private func removeShimmerLayer(view: UIView) {
        let viewStringKey = String(describing: view)
        guard let shimmerLayer = shimmerLayersMap[viewStringKey] else { return }
        shimmerLayer.removeFromSuperlayer()
        shimmerLayersMap[viewStringKey] = nil
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.cellOuterSpacing.y),
            recipeView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: Constants.cellOuterSpacing.x
            ),
            contentView.trailingAnchor.constraint(
                equalTo: recipeView.trailingAnchor, constant: Constants.cellOuterSpacing.x
            ),
            contentView.bottomAnchor.constraint(
                equalTo: recipeView.bottomAnchor,
                constant: Constants.cellOuterSpacing.y
            ),

            recipeStackView.topAnchor.constraint(equalTo: recipeView.topAnchor, constant: Constants.cellInnerSpacing),
            recipeStackView.leadingAnchor.constraint(
                equalTo: recipeView.leadingAnchor,
                constant: Constants.cellInnerSpacing
            ),
            recipeView.trailingAnchor.constraint(
                equalTo: recipeStackView.trailingAnchor,
                constant: Constants.cellInnerSpacing
            ),
            recipeView.bottomAnchor.constraint(
                equalTo: recipeStackView.bottomAnchor,
                constant: Constants.cellInnerSpacing
            ),
        ])
    }

    private func makeInfoStack(label: UILabel, image: UIImage?) -> UIStackView {
        let imageView = UIImageView(image: image)
        imageView.disableAutoresizingMask()
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.infoIconSize),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        label.font = .verdana(ofSize: 12)
        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.spacing = Constants.infoIconToLabelSpacing
        stack.alignment = .leading
        stack.disableAutoresizingMask()
        return stack
    }
}
