// ProfileConfiguration.swift
// Copyright © RoadMap. All rights reserved.

/// Конфигурация профиля
final class ProfileConfiguration {
    typealias ProfileCells = [ProfileCellType]
    /// варианты ячеек на экране профиля
    enum ProfileCellType {
        /// Информация о профиле
        case profile(ProfileInfo)
        /// Настройка
        case setting(ProfileSettingOption)
    }

    /// Тип доступных настроек
    enum ProfileSettingType {
        /// Количество бонусов
        case bonuses
        /// Условия использования
        case terms
        /// Выход из системы
        case logout
    }

    static let shared = ProfileConfiguration()

    private static let profileInfoMock = ProfileInfo(
        avatarImageName: Originator.shared.memento?.userImageName ?? "",
        fullName: Originator.shared.memento?.userName ?? "",
        bonusesCount: 105
    )
    private static let bonusesSetting = ProfileSettingOption(
        type: .bonuses,
        title: "Bonuses",
        iconImageName: "star"
    )
    private static let termsSetting = ProfileSettingOption(
        type: .terms,
        title: "Terms & Privacy Policy",
        iconImageName: "paper"
    )
    private static let logoutSetting = ProfileSettingOption(
        type: .logout,
        title: "Log out",
        iconImageName: "logout"
    )

    private(set) var profileInfo: ProfileInfo = profileInfoMock

    var profileTableCells: [ProfileCellType] {
        [
            .profile(profileInfo),
            .setting(ProfileConfiguration.bonusesSetting),
            .setting(ProfileConfiguration.termsSetting),
            .setting(ProfileConfiguration.logoutSetting)
        ]
    }

    func updateFullName(_ fullName: String) {
        profileInfo.fullName = fullName
    }

    func updateBonusesCount(_ bonusesCount: Int) {
        profileInfo.bonusesCount = bonusesCount
    }
}
