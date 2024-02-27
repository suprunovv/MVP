// LoginViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol LoginPresenterProtocol: AnyObject {
    var authCoordinator: AuthCoordinator? { get set }
    /// Метод получает пароль и валидирует его
    func validatePassword(password: String)
    /// Метод скрывает/показывает пароль и меняет картику кнопки с глазком
    func toggleSecureButton()
    /// Метод валидации email
    func emailValidate(email: String)
}

protocol LoginViewProtocol: AnyObject {
    /// Меотод выполняет выполняет действие если пароль не валидный
    func invalidePassword(_ bool: Bool, color: UIColor)
    /// Метод выплняет действие по нажатию на кнопку secureButton
    func updatePasswordSecuredUI(_ isSecured: Bool, image: UIImage?)
    /// Метод возвращает булевое значение (Правильный ли email)
    func isValideEmail(_ bool: Bool, color: UIColor)
    /// Метод вызывает переход на следующий экран
    func goToSecondView()

    // TODO: add documentation
    func setEmailValidationError(_ error: String?)
    func setPasswordValidationError(_ error: String?)
    func clearPasswordValidationError()
    func clearEmailValidationError()
}

/// Презентер для экрана логин
final class LoginPresenter {
    weak var authCoordinator: AuthCoordinator?
    private let loginFormValidator = LoginFormValidator()

    private weak var view: LoginViewProtocol?
    init(view: LoginViewProtocol) {
        self.view = view
    }

    private var isPasswordSecured = true
    private var isValid = (password: false, login: false)
}

// MARK: - LoginPresenter + LoginPresenterProtocol

extension LoginPresenter: LoginPresenterProtocol {
    func validatePassword(password: String) {
        let validationError = loginFormValidator.validatePassword(password)
        if let validationError {
            view?.setPasswordValidationError(validationError)
            isValid.password = false
        } else {
            view?.clearPasswordValidationError()
            isValid.password = true
        }

        if isValid == (true, true) {
            authCoordinator?.didLogin()
        }
    }

    func emailValidate(email: String) {
        let validationError = loginFormValidator.validateEmail(email)
        if let validationError {
            view?.setEmailValidationError(validationError)
            isValid.login = false
        } else {
            view?.clearEmailValidationError()
            isValid.login = true
        }
    }

    func toggleSecureButton() {
        isPasswordSecured.toggle()
        view?.updatePasswordSecuredUI(isPasswordSecured, image: isPasswordSecured ? .eyeSlashImage : .eyeFill)
    }
}
