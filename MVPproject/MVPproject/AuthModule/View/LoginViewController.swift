// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью экрана входа
final class LoginViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let loginTitle = "Login"
        static let emailLabelText = "Email Address"
        static let passwordLabelText = "Password"
        static let emailTextFiledPlaceholder = "Enter Email Address"
        static let passwordTextFiledPlaceholder = "Enter Password"
        static let incorrectEmailText = "Incorrect format"
        static let incorrectPasswordText = "You entered the wrong password"
    }

    // MARK: - Visual Compontnts

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.loginTitle, for: .normal)
        button.backgroundColor = .greenDarkButton
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .verdana(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 28)
        label.text = Constants.loginTitle
        label.textColor = .grayText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 18)
        label.text = Constants.emailLabelText
        label.textColor = .grayText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let incorrectEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 12)
        label.text = Constants.incorrectEmailText
        label.textColor = .redError
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let incorrectPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 12)
        label.text = Constants.incorrectPasswordText
        label.textColor = .redError
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 18)
        label.text = Constants.passwordLabelText
        label.textColor = .grayText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = Constants.emailTextFiledPlaceholder
        textFiled.borderStyle = .none
        textFiled.layer.borderColor = UIColor.systemGray.cgColor
        textFiled.layer.borderWidth = 1
        textFiled.clearButtonMode = .whileEditing
        textFiled.backgroundColor = .white
        textFiled.clipsToBounds = true
        textFiled.layer.cornerRadius = 12
        textFiled.leftViewMode = .always
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        return textFiled
    }()

    private let passwordTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = Constants.passwordTextFiledPlaceholder
        textFiled.isSecureTextEntry = true
        textFiled.borderStyle = .none
        textFiled.layer.borderColor = UIColor.systemGray.cgColor
        textFiled.layer.borderWidth = 1
        textFiled.backgroundColor = .white
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
        button.setImage(.eyeSlashImage, for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    private let emailImageView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.emailImage, for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    private let passwordImageView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.passwordImage, for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    private var emailStackView: UIStackView!

    private var passwordStackView: UIStackView!

    var presenter: LoginPresenterProtocol?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    // MARK: Private methods

    private func setView() {
        view.backgroundColor = .white
        setupGradient()
        setTitleLabelConstraints()
        setEmailStackView()
        setPasswordStackView()
        setLoginButtonConstraints()
        setSecureButton()
        setEmailFieldLeftImageView()
        setPasswordFieldLeftImageView()
        addTargetButtons()
        addTextFiledDelegate()
        setIncorrectEmailLabelConstraint()
        setIncorrectPasswordLabelConstraint()
    }

    private func addTextFiledDelegate() {
        emailTextFiled.delegate = self
    }

    private func setupGradient() {
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
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -37)
        ])
    }

    private func setIncorrectEmailLabelConstraint() {
        view.addSubview(incorrectEmailLabel)
        NSLayoutConstraint.activate([
            incorrectEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            incorrectEmailLabel.topAnchor.constraint(equalTo: emailStackView.bottomAnchor)
        ])
    }

    private func setIncorrectPasswordLabelConstraint() {
        view.addSubview(incorrectPasswordLabel)
        NSLayoutConstraint.activate([
            incorrectPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            incorrectPasswordLabel.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor)
        ])
    }

    private func setSecureButton() {
        let view = makeTextFieldView(wrappedView: securePasswordButton)
        passwordTextFiled.rightView = view
    }

    private func setEmailFieldLeftImageView() {
        let view = makeTextFieldView(wrappedView: emailImageView)
        emailTextFiled.leftView = view
    }

    private func setPasswordFieldLeftImageView() {
        let view = makeTextFieldView(wrappedView: passwordImageView)
        passwordTextFiled.leftView = view
    }

    private func makeTextFieldView(wrappedView: UIView) -> UIView {
        let view = UIView()
        view.addSubview(wrappedView)
        view.widthAnchor.constraint(equalToConstant: 60).isActive = true
        wrappedView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wrappedView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }

    private func addTargetButtons() {
        loginButton.addTarget(self, action: #selector(tappLoginButton), for: .touchUpInside)
        securePasswordButton.addTarget(self, action: #selector(secureButtonTapped), for: .touchUpInside)
    }

    @objc private func secureButtonTapped() {
        presenter?.toggleSecureButton()
    }

    @objc private func tappLoginButton() {
        let password = passwordTextFiled.text ?? ""
        presenter?.validatePassword(password: password)
    }
}

// MARK: - LoginViewController + LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func updatePasswordSecuredUI(_ isSecured: Bool, image: UIImage?) {
        securePasswordButton.setImage(image, for: .normal)
        passwordTextFiled.isSecureTextEntry = isSecured
    }

    func setEmailValidationError(_ error: String?) {
        emailTextFiled.layer.borderColor = UIColor.redError.cgColor
        incorrectEmailLabel.isHidden = false
        incorrectEmailLabel.text = error
        emailLabel.textColor = .redError
    }

    func clearEmailValidationError() {
        emailTextFiled.layer.borderColor = UIColor.systemGray.cgColor
        incorrectEmailLabel.isHidden = true
        emailLabel.textColor = .systemGray
    }

    func setPasswordValidationError(_ error: String?) {
        passwordTextFiled.layer.borderColor = UIColor.redError.cgColor
        incorrectPasswordLabel.isHidden = false
        incorrectPasswordLabel.text = error
        passwordTextFiled.textColor = .redError
    }

    func clearPasswordValidationError() {
        passwordTextFiled.layer.borderColor = UIColor.systemGray.cgColor
        incorrectPasswordLabel.isHidden = true
        passwordTextFiled.textColor = .systemGray
    }

    func invalidePassword(_ bool: Bool, color: UIColor) {
        passwordTextFiled.layer.borderColor = color.cgColor
        incorrectPasswordLabel.isHidden = bool
        passwordLabel.textColor = color
    }

    func isValideEmail(_ bool: Bool, color: UIColor) {
        emailTextFiled.layer.borderColor = color.cgColor
        incorrectEmailLabel.isHidden = bool
        emailLabel.textColor = color
    }

    func goToSecondView() {
        print("Перехожу")
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == emailTextFiled {
            let text = emailTextFiled.text ?? ""
            presenter?.emailValidate(email: text)
        }
    }
}
