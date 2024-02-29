// SortButtonsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol SortButtonViewDelegate: AnyObject {}

/// Вью с 2мя кнопками сортировки
final class SortButtonsView: UIView {
    // MARK: - Visual components

    private var caloriesButtonState = 0
    private var timeButtonState = 0

    private let caloriesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calories  ", for: .normal)
        button.setImage(.stackUp, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 12
        button.tintColor = .black
        return button
    }()

    private let timeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Time  ", for: .normal)
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

    weak var delegate: SortButtonViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

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
        buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        buttonsStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }

    @objc private func tapSortButton(_ sender: UIButton) {
        switch sender {
        case caloriesButton:
            timeButtonState = 0
            timeButton.backgroundColor = .systemGray4
            timeButton.setImage(.stackUp, for: .normal)
            timeButton.tintColor = .black
            caloriesButtonState += 1
            if caloriesButtonState == 1 {
                caloriesButton.backgroundColor = .systemGray2
                caloriesButton.tintColor = .white
            } else if caloriesButtonState == 2 {
                caloriesButton.setImage(.stackDown, for: .normal)
            } else {
                caloriesButtonState = 0
                caloriesButton.backgroundColor = .systemGray4
                caloriesButton.setImage(.stackUp, for: .normal)
                caloriesButton.tintColor = .black
            }
        case timeButton:
            caloriesButtonState = 0
            caloriesButton.backgroundColor = .systemGray4
            caloriesButton.setImage(.stackUp, for: .normal)
            caloriesButton.tintColor = .black
            timeButtonState += 1
            if timeButtonState == 1 {
                timeButton.backgroundColor = .systemGray2
                timeButton.tintColor = .white
            } else if timeButtonState == 2 {
                timeButton.setImage(.stackDown, for: .normal)
            } else {
                timeButtonState = 0
                timeButton.backgroundColor = .systemGray4
                timeButton.setImage(.stackUp, for: .normal)
                timeButton.tintColor = .black
            }
        default: break
        }
    }
}
