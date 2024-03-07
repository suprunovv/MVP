// Originator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сохранение данных в userDefaults и создание мементо
final class Originator {
    
    // MARK: - Constants
    static let shared = Originator()
    private enum Constants {
        static let mementoKey = "memento"
        static let firstLoadingKay = "firstLoading"
        static let userNameKay = "userName"
        static let defaultUserName = "Surname Name"
    }
    
    // MARK: - Public properties

    var memento: Memento?

    // MARK: - Initializators
    
    private init() {}

    // MARK: - Public methods 
    func setPersonData(data: PersonData) {
        memento = Memento(personData: data, isFirstLoading: false)
    }

    func saveToUserDefaults() {
        if memento == nil {
            memento = Memento(personData: PersonData(email: "", password: ""), isFirstLoading: true)
        }
        let encoder = JSONEncoder()
        let data = try? encoder.encode(memento)
        UserDefaults.standard.set(data, forKey: Constants.mementoKey)
    }

    func restoreFromUserDefaults() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: Constants.mementoKey) {
            memento = try? decoder.decode(Memento.self, from: data)
        }
    }

    func setUserName(userName: String) {
        memento?.userName = userName
    }

    func setUserAvatar(imageName: String) {
        memento?.userImageName = imageName
    }
}
