//
//  Memento.swift
//  MVPproject
//
//  Created by MacBookPro on 07.03.2024.
//

import Foundation

/// Мементо
final class Memento: Codable {
    
    // MARK: - Comnstants
    private enum Constants {
        static let defaultUserName = "Surname Name"
        static let defaultImageName = "profileAvatar"
    }
    
    // MARK: - Public properties

    var personData: PersonData
    var isFirstLoading: Bool
    var userName: String = Constants.defaultUserName
    var userImageName: String = Constants.defaultImageName
    
    // MARK: - Initializators
    
    init(personData: PersonData, isFirstLoading: Bool) {
        self.personData = personData
        self.isFirstLoading = isFirstLoading
    }
}
