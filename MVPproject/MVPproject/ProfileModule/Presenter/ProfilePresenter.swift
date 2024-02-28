// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера профиля
protocol ProfilePresenterProtocol: AnyObject {
    /// Обновление данных профиля
    func refreshProfileData()
    /// Обработка запроса на изменение имени
    func editNameButtonTapped()
    /// Обработка изменения имени
    func handleNameChanged(_ fullName: String)
}

/// Презентер экрана профиля
final class ProfilePresenter {
    private weak var profileCoordinator: ProfileCoordinator?
    private weak var view: ProfileViewProtocol?

    private var profileConfiguration = ProfileConfiguration()

    init(view: ProfileViewProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        profileCoordinator = coordinator
    }
}

// MARK: - ProfilePresenter + ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    func handleNameChanged(_ fullName: String) {
        profileConfiguration.updateFullName(fullName)
        view?.updateProfile(profileCells: profileConfiguration.profileTableCells)
    }

    func editNameButtonTapped() {
        view?.showNameEdit(
            title: "Change your name and surname",
            currentName: profileConfiguration.profileInfo.fullName
        )
    }

    func refreshProfileData() {
        view?.updateProfile(profileCells: profileConfiguration.profileTableCells)
    }
}
