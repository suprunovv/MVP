// LoginViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера логина
protocol LoginPresenterProtocol: AnyObject {
    /// Координатор потока авторизации
    var authCoordinator: AuthCoordinator? { get set }
    /// Метод получает пароль и валидирует его
    func validatePassword(password: String)
    /// Метод валидации email
    func validateEmail(email: String)
    /// Метод скрывает/показывает пароль и меняет картику кнопки с глазком
    func toggleSecureButton()
}

/// Протокол представления логина
protocol LoginViewProtocol: AnyObject {
    /// Метод обновляющий UI скрывающий/открывающий пароль
    func updatePasswordSecuredUI(_ isSecured: Bool, image: UIImage?)
    /// Установка ошибки валидации email
    func setEmailValidationError(_ error: String?)
    /// Установка ошибки валидации password
    func setPasswordValidationError(_ error: String?)
    /// Сброс ошибки валидации email
    func clearPasswordValidationError()
    /// Сброс ошибки валидации password
    func clearEmailValidationError()
}

/// Презентер для экрана логин
final class LoginPresenter {
    weak var authCoordinator: AuthCoordinator?
    private weak var view: LoginViewProtocol?

    private var isPasswordSecured = true
    private var isValid = (password: false, login: false)
    private let loginFormValidator = LoginFormValidator()

    init(view: LoginViewProtocol) {
        self.view = view
    }
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

    func validateEmail(email: String) {
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
