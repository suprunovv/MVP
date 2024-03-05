// AuthService.swift
// Copyright © RoadMap. All rights reserved.

/// Сервис авторизации приложения
final class AuthService {
    /// Состояние приложения
    enum State {
        /// Не авторизован
        case unauthorized
        /// Пользователь залогинен
        case loggedIn(PersonData)
    }

    /// Общий истанс на все приложение
    static let shared = AuthService()

    private(set) var state: State = .loggedIn(PersonData(email: "", password: ""))

    func login(_ user: PersonData) {
        state = .loggedIn(user)
    }
}
