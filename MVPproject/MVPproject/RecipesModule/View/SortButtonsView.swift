// SortButtonsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для делегата SortButtonsView
protocol SortButtonViewDelegate: AnyObject {}

/// Вью с 2мя кнопками сортировки
final class SortButtonsView: UIView {
    
    // MARK: - Constants 
    
    /// Перечисление состояний кнопок
    enum SortState {
        case unsorted
        case ascending
        case descending

        mutating func changeSort() {
            switch self {
            case .unsorted:
                self = .ascending
            case .ascending:
                self = .descending
            case .descending:
                self = .unsorted
            }
        }
    }

    enum Constants {
        static let calloriesTitle = "Calories  "
        static let timeTitle = "Time  "
    }

    // MARK: - Visual components

    private let caloriesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.calloriesTitle, for: .normal)
        button.setImage(.stackUp, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 12
        button.tintColor = .black
        return button
    }()

    private let timeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.timeTitle, for: .normal)
        button.setImage(.stackUp, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 12
        button.tintColor = .black
        return button
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [caloriesButton, timeButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 11
        stack.disableAutoresizingMask()
        timeButton.widthAnchor.constraint(equalTo: caloriesButton.widthAnchor, multiplier: 0.8).isActive = true

        return stack
    }()

    // MARK: - Private properties

    private var caloriesButtonState: SortState = .unsorted
    private var timeButtonState: SortState = .unsorted

    // MARK: - Public properties

    weak var delegate: SortButtonViewDelegate?

    // MARK: - Initializators

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Private methods

    private func setupView() {
        disableAutoresizingMask()
        addSubview(buttonsStackView)
        setButtonsStackConstaints()
        addButtonsTarget()
    }

    private func addButtonsTarget() {
        caloriesButton.addTarget(self, action: #selector(tapSortButton(_:)), for: .touchUpInside)
        timeButton.addTarget(self, action: #selector(tapSortButton(_:)), for: .touchUpInside)
    }

    private func setButtonsStackConstaints() {
        buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor).activate()
        buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
        buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor).activate()
        buttonsStackView.topAnchor.constraint(equalTo: topAnchor).activate()
    }

    @objc private func tapSortButton(_ sender: UIButton) {
        switch sender {
        case caloriesButton:
            timeButtonState = .unsorted
            timeButton.backgroundColor = .systemGray4
            timeButton.setImage(.stackUp, for: .normal)
            timeButton.tintColor = .black
            caloriesButtonState.changeSort()
            if caloriesButtonState == .ascending {
                caloriesButton.backgroundColor = .systemGray2
                caloriesButton.tintColor = .white
            } else if caloriesButtonState == .descending {
                caloriesButton.setImage(.stackDown, for: .normal)
            } else {
                caloriesButtonState.changeSort()
                caloriesButton.backgroundColor = .systemGray4
                caloriesButton.setImage(.stackUp, for: .normal)
                caloriesButton.tintColor = .black
            }
        case timeButton:
            caloriesButtonState = .unsorted
            caloriesButton.backgroundColor = .systemGray4
            caloriesButton.setImage(.stackUp, for: .normal)
            caloriesButton.tintColor = .black
            timeButtonState.changeSort()
            if timeButtonState == .ascending {
                timeButton.backgroundColor = .systemGray2
                timeButton.tintColor = .white
            } else if timeButtonState == .descending {
                timeButton.setImage(.stackDown, for: .normal)
            } else {
                timeButtonState = .unsorted
                timeButton.backgroundColor = .systemGray4
                timeButton.setImage(.stackUp, for: .normal)
                timeButton.tintColor = .black
            }
        default: break
        }
    }
}
