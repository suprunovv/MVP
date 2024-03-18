// AuthService.swift
// Copyright © RoadMap. All rights reserved.

import Keychain

/// Сервис авторизации приложения
final class AuthService {
    /// Состояние приложения
    enum State {
        /// Не авторизован
        case unauthorized
        /// Пользователь залогинен
        case loggedIn
    }

    /// Общий истанс на все приложение
    static let shared = AuthService()

    private(set) var state: State = .unauthorized

    func login(_ user: PersonData) {
        state = .loggedIn
        saveCredentials(user)
    }

    func restoreCredentials() -> PersonData? {
        let email = Keychain.load("email")
        let password = Keychain.load("password")
        if let email = email, let password = password {
            return PersonData(email: email, password: password)
        }

        return nil
    }

    private func saveCredentials(_ credentials: PersonData) {
        _ = Keychain.save(credentials.email, forKey: "email")
        _ = Keychain.save(credentials.password, forKey: "password")
    }
}
