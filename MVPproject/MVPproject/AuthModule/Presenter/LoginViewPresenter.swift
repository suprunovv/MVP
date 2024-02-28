// LoginViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера логина
protocol LoginPresenterProtocol: AnyObject {
    /// Метод получает пароль и валидирует его
    func validatePassword(password: String)
    /// Метод валидации email
    func validateEmail(email: String)
    /// Метод скрывает/показывает пароль и меняет картику кнопки с глазком
    func toggleSecureButton()
    /// Метод обрабатывает нажатие на вью и вызывает у нее метод скрывающий клавиатуру
    func hideViewKeyboard()
}

/// Презентер для экрана логин
final class LoginPresenter {
    private weak var authCoordinator: AuthCoordinator?
    private weak var view: LoginViewProtocol?

    private var isPasswordSecured = true
    private var isValid = (password: false, login: false)
    private let loginFormValidator = LoginFormValidator()
    private var timer = Timer()

    init(view: LoginViewProtocol, coordinator: AuthCoordinator) {
        self.view = view
        authCoordinator = coordinator
    }

    private func startTimer(timeInterval: TimeInterval, handler: @escaping (Timer) -> Void) {
        timer = Timer.scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: false,
            block: handler
        )
    }
}

// MARK: - LoginPresenter + LoginPresenterProtocol

extension LoginPresenter: LoginPresenterProtocol {
    func hideViewKeyboard() {
        view?.hideKeyboardOnTap()
    }

    func validatePassword(password: String) {
        let validationError = loginFormValidator.validatePassword(password)
        if let validationError = validationError {
            view?.setPasswordValidationError(validationError)
            isValid.password = false
        } else {
            view?.clearPasswordValidationError()
            isValid.password = true
        }

        if isValid == (true, true) {
            view?.startActivityIndicator()
            view?.hideTextLoginButton()
            startTimer(timeInterval: 3) { [weak self] timer in
                self?.view?.stopActivityIndicator()
                self?.view?.returnTextLoginButton()
                self?.view?.presentErrorLoginView()
                timer.invalidate()
                self?.startTimer(timeInterval: 2) { [weak self] timer in
                    self?.view?.hideErrorLoginView()
                    timer.invalidate()
                    self?.authCoordinator?.didLogin()
                }
            }
        }
    }

    func validateEmail(email: String) {
        let validationError = loginFormValidator.validateEmail(email)
        if let validationError = validationError {
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
