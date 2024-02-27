// LoginViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol PresenterProtocol: AnyObject {
    /// Метод получает пароль и валидирует его
    func validatePassword(password: String)
    /// Метод скрывает/показывает пароль и меняет картику кнопки с глазком
    func toggleSecureButton()
    /// Метод валидации email
    func emailValidate(email: String)
}

protocol ViewProtocol: AnyObject {
    /// Меотод выполняет выполняет действие если пароль не валидный
    func invalidePassword(_ bool: Bool, color: UIColor)
    /// Метод выплняет действие по нажатию на кнопку secureButton
    func tapSecureButton(isSecure: Bool, image: UIImage)
    /// Метод возвращает булевое значение (Правильный ли email)
    func isValideEmail(_ bool: Bool, color: UIColor)
    /// Метод вызывает переход на следующий экран
    func goToSecondView()
}

/// Презентер для экрана логин
final class LoginViewPresenter {
    weak var view: ViewProtocol?

    private var isSecureButton = true
    private var isValide = (password: false, login: false)
}

/// LoginViewPresenter + Extension
extension LoginViewPresenter: PresenterProtocol {
    func validatePassword(password: String) {
        guard password.count > 8 else {
            view?.invalidePassword(false, color: .errorColor)
            isValide.password = false
            return
        }
        view?.invalidePassword(true, color: .systemGray)
        isValide.password = true
        if isValide == (true, true) {
            view?.goToSecondView()
        }
    }

    func emailValidate(email: String) {
        guard email.count >= 6 else {
            view?.isValideEmail(false, color: .errorColor)
            isValide.login = false
            return
        }
        guard email.contains("@"), email.contains(".") else {
            isValide.login = false
            view?.isValideEmail(false, color: .errorColor)
            return
        }
        view?.isValideEmail(true, color: .systemGray)
        isValide.login = true
    }

    func toggleSecureButton() {
        isSecureButton.toggle()
        if isSecureButton {
            view?.tapSecureButton(isSecure: isSecureButton, image: .eyeSlashImage ?? UIImage())
        } else {
            view?.tapSecureButton(isSecure: isSecureButton, image: .eyeFill ?? UIImage())
        }
    }
}
