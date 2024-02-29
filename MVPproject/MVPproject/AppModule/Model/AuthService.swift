// AuthService.swift
// Copyright © RoadMap. All rights reserved.

/// Модель приложения
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

    private(set) var state: State = .unauthorized

    func login(_ user: PersonData) {
        state = .loggedIn(user)
    }
}
