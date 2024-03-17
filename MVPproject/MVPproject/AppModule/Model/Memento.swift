// Memento.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Мементо
final class Memento: Codable {
    // MARK: - Constants

    private enum Constants {
        static let defaultUserName = "Surname Name "
    }

    // MARK: - Public properties

    private(set) var personData: PersonData
    private(set) var isFirstLoading: Bool
    private(set) var userName: String = Constants.defaultUserName
    private(set) var userImageData: Data?

    // MARK: - Initializators

    init(personData: PersonData, isFirstLoading: Bool) {
        self.personData = personData
        self.isFirstLoading = isFirstLoading
    }

    func setUserName(userName: String) {
        self.userName = userName
    }

    func setUserImageData(imageData: Data) {
        userImageData = imageData
    }
}
