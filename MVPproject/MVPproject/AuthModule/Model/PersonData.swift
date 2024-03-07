// PersonData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель данных пользователя
class PersonData: Codable {
    private enum PersonDataKeys: String {
        case email
        case password
    }

    // Email Пользователя
    private var email: String = ""
    // Пароль Пользователя
    private var password: String = ""

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    func encode(with coder: NSCoder) {
        coder.encode(email, forKey: PersonDataKeys.email.rawValue)
        coder.encode(password, forKey: PersonDataKeys.password.rawValue)
    }

    required init?(coder: NSCoder) {
        email = coder.decodeObject(forKey: PersonDataKeys.email.rawValue) as? String ?? ""
        password = coder.decodeObject(forKey: PersonDataKeys.password.rawValue) as? String ?? ""
    }

    func getPassword() -> String {
        password
    }

    func getEmail() -> String {
        email
    }
}
