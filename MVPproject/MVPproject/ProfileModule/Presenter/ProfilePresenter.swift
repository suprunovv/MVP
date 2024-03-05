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
    /// Показать бонусы
    func showBonuses()
    /// Показать tetms
    func showTerms()
    /// Обработка выбора настройки
    func settingSelected(_ profileSetting: ProfileConfiguration.ProfileSettingType)
}

/// Презентер экрана профиля
final class ProfilePresenter {
    private weak var profileCoordinator: ProfileCoordinator?
    private weak var view: ProfileViewProtocol?

    private var profileConfiguration = ProfileConfiguration.shared

    init(view: ProfileViewProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        profileCoordinator = coordinator
    }
}

// MARK: - ProfilePresenter + ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func showTerms() {
        view?.showTerms()
    }

    func settingSelected(_ profileSettingType: ProfileConfiguration.ProfileSettingType) {
        switch profileSettingType {
        case .bonuses:
            showBonuses()
        case .terms:
            showTerms()
        default:
            break
        }
    }

    func showBonuses() {
        profileCoordinator?.showBonuses()
    }

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
