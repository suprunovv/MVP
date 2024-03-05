// TermsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol TermsViewDelegate: AnyObject {
    /// Метод для закрытия вью
    func hideTermsView()
}

/// Вью с политикой
final class TermsView: UIView {
    
    // MARK: - Constants
    enum Constants {
        static let titleText = "Terms of Use"
        static let infoLabelText = """
        Welcome to our recipe app! We're thrilled to have
        you on board. To ensure a delightful experience
        for everyone, please take a moment to familiarize
        yourself with our rules:
        User Accounts:
        · Maintain one account per user.
        · Safeguard your login credentials; don't share them with others.
        Content Usage:
        · Recipes and content are for personal use only.
        · Do not redistribute or republish recipes without proper attribution.
        Respect Copyright:
        · Honor the copyright of recipe authors and contributors.
        · Credit the original source when adapting or modifying a recipe.
        Community Guidelines:
        · Show respect in community features.
        · Avoid offensive language or content that violates community standards.
        Feedback and Reviews:
        · Share constructive feedback and reviews.
        · Do not submit false or misleading information.
        Data Privacy:
        ·  Review and understand our privacy policy regarding data collection and usage.
        Compliance with Laws:
        · Use the app in compliance with all applicable laws and regulations.
        Updates to Terms:
        · Stay informed about updates; we'll notify you of any changes.
        · By using our recipe app, you agree to adhere to these rules.
        Thank you for being a part of our culinary community!
        Enjoy exploring and cooking up a storm!
        """
    }
    
    // MARK: - Visual components

    private let lineView: UIView = {
        let view = UIView()
        view.disableAutoresizingMask()
        view.backgroundColor = .blueSearch
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 20)
        label.textColor = .black
        label.text = Constants.titleText
        label.disableAutoresizingMask()
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.xMark, for: .normal)
        button.tintColor = .black
        button.disableAutoresizingMask()
        return button
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = Constants.infoLabelText
        label.disableAutoresizingMask()
        return label
    }()

    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.disableAutoresizingMask()
        return view
    }()
    
    // MARK: - Public properties

    weak var delegate: TermsViewDelegate?

    // MARK: - Initializators
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public methods
    func addGestureRecognizer(_ recognizer: UIPanGestureRecognizer) {
        topView.addGestureRecognizer(recognizer)
    }

    // MARK: - Private methods
    
    private func setupView() {
        layer.cornerRadius = 30
        clipsToBounds = true
        backgroundColor = .white
        setTopViewConstraints()
        setLineViewConstraints()
        setTitleLabelConstraints()
        setCloseButton()
        setInfoLabel()
    }

    private func setTopViewConstraints() {
        addSubview(topView)
        topView.leadingAnchor.constraint(equalTo: leadingAnchor).activate()
        topView.heightAnchor.constraint(equalToConstant: 34).activate()
        topView.trailingAnchor.constraint(equalTo: trailingAnchor).activate()
        topView.topAnchor.constraint(equalTo: topAnchor).activate()
    }

    private func setLineViewConstraints() {
        topView.addSubview(lineView)
        lineView.heightAnchor.constraint(equalToConstant: 5).activate()
        lineView.widthAnchor.constraint(equalToConstant: 50).activate()
        lineView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).activate()
        lineView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).activate()
    }

    private func setTitleLabelConstraints() {
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).activate()
        titleLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16).activate()
    }

    private func setCloseButton() {
        addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        closeButton.heightAnchor.constraint(equalToConstant: 14).activate()
        closeButton.widthAnchor.constraint(equalToConstant: 14).activate()
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).activate()
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).activate()
    }

    private func setInfoLabel() {
        addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).activate()
        infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).activate()
        infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).activate()
    }

    @objc private func tapCloseButton() {
        delegate?.hideTermsView()
    }
}
