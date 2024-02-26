// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью экрана входа
final class LoginViewController: UIViewController {
    
    // MARK: - Constants
    enum Constants {
        static let loginTitle = "Login"
        static let emailLabelText = "Emale Address"
        static let passwordLabelText = "Password"
        static let emailTextFiledPlaceholder = "Enter Email Address"
        static let passwordTextFiledPlaceholder = "Enter Password"
        static let emailImage = UIImage(named: "envelop")
        static let passwordImage = UIImage(named: "lock")
        static let eyeSlashImage = UIImage(systemName: "eye.slash.fill")
    }

    // MARK: - Visual Compontnts
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.loginTitle, for: .normal)
        button.backgroundColor = .loginButtonColor
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .verdana16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold28
        label.text = Constants.loginTitle
        label.textColor = .labelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold18
        label.text = Constants.emailLabelText
        label.textColor = .labelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold18
        label.text = Constants.passwordLabelText
        label.textColor = .labelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = Constants.emailTextFiledPlaceholder
        textFiled.borderStyle = .roundedRect
        textFiled.clipsToBounds = true
        textFiled.layer.cornerRadius = 12
        textFiled.leftViewMode = .always
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        return textFiled
    }()

    private let passwordTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = Constants.passwordTextFiledPlaceholder
        textFiled.borderStyle = .roundedRect
        textFiled.clipsToBounds = true
        textFiled.layer.cornerRadius = 12
        textFiled.leftViewMode = .always
        textFiled.rightViewMode = .always
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        return textFiled
    }()

    private let securePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.eyeSlashImage, for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    private let emailImageView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.emailImage, for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    private let passwordImageView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.passwordImage, for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    private var emailStackView: UIStackView!
    private var passwordStackView: UIStackView!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setGradient()
        setTitleLabelConstraints()
        setEmailStackView()
        setPasswordStackView()
        setLoginButtonConstraints()
        setSecureButton()
        setLeftTextFiledImageView()
    }
    
    // MARK: Private methods

    private func setGradient() {
        let gradient = CAGradientLayer()
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1).cgColor,
            UIColor.systemGray3.cgColor
        ]
        view.layer.insertSublayer(gradient, at: 0)
    }

    private func setTitleLabelConstraints() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 82)
        ])
    }

    private func setEmailStackView() {
        emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextFiled])
        emailStackView.axis = .vertical
        emailStackView.distribution = .fill
        emailStackView.spacing = 6
        view.addSubview(emailStackView)
        emailStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailStackView.heightAnchor.constraint(equalToConstant: 88),
            emailStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 137),
            emailTextFiled.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setPasswordStackView() {
        passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextFiled])
        passwordStackView.axis = .vertical
        passwordStackView.distribution = .fill
        passwordStackView.spacing = 6
        view.addSubview(passwordStackView)
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordStackView.heightAnchor.constraint(equalToConstant: 88),
            passwordStackView.topAnchor.constraint(equalTo: emailStackView.bottomAnchor, constant: 23),
            passwordTextFiled.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setLoginButtonConstraints() {
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -37)
        ])
    }

    private func setSecureButton() {
        securePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        securePasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        securePasswordButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        passwordTextFiled.rightView = securePasswordButton
    }

    private func setLeftTextFiledImageView() {
        passwordImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        emailImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        passwordImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextFiled.leftView = passwordImageView
        emailTextFiled.leftView = emailImageView
    }
}

extension UIColor {
    static let labelColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1)
    static let loginButtonColor = UIColor(red: 4 / 255, green: 38 / 255, blue: 40 / 255, alpha: 1)
}

extension UIFont {
    static let verdanaBold28 = UIFont(name: "Verdana-Bold", size: 28)
    static let verdanaBold18 = UIFont(name: "Verdana-Bold", size: 18)
    static let verdana16 = UIFont(name: "Verdana", size: 16)
}
