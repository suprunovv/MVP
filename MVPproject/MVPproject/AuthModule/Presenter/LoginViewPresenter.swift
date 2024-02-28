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
    /// Метод обрабатывает нажатие на вью и вызывает у нее метод скрывающий клавиатуру
    func hideViewKeyboard()
}

protocol LoginViewProtocol: AnyObject {
    /// Метод выплняет действие по нажатию на кнопку secureButton
    func updatePasswordSecuredUI(_ isSecured: Bool, image: UIImage?)
    /// Метод вызывает переход на следующий экран
    func goToSecondView()
    /// Метод запускает индикатор загрузки
    func startActivityIndicator()
    /// Метод останавливает индикатор загрузки
    func stopActivityIndicator()
    /// Метод убирает текст у кнопки Login
    func hideTextLoginButton()
    /// Метод возвращает текст кнопке Login
    func returnTextLoginButton()
    /// Метод показывает вьшку с предупреждением что вход не выполнен
    func presentErrorLoginView()
    /// Метод скрывает вьюшку с предупреждением что вход не выполнен
    func hideErrorLoginView()
    // TODO: add documentation
    func setEmailValidationError(_ error: String?)
    func setPasswordValidationError(_ error: String?)
    func clearPasswordValidationError()
    func clearEmailValidationError()
    // Метод скрывает клавиатуру по нажатию на любую область экрана
    func hideKeyboardOnTap()
}

/// Презентер для экрана логин
final class LoginPresenter {
    weak var authCoordinator: AuthCoordinator?
    private let loginFormValidator = LoginFormValidator()
    private var timer = Timer()
    private weak var view: LoginViewProtocol?
    init(view: LoginViewProtocol) {
        self.view = view
    }

    private var isPasswordSecured = true
    private var isValid = (password: false, login: false)

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
            // authCoordinator?.didLogin()
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
                }
            }
        }
    }

    func emailValidate(email: String) {
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
