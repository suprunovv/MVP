// ProfileConfiguration.swift
// Copyright © RoadMap. All rights reserved.

/// Кнфигурация таблицы на экране профиля
struct ProfileConfiguration {
    typealias ProfileCells = [ProfileCellType]
    /// варианты ячеек на экране профиля
    enum ProfileCellType {
        /// Информация о профиле
        case profile(ProfileInfo)
        /// Настройка
        case setting(ProfileSettingOption)
    }

    private static let profileInfoMock = ProfileInfo(avatarImageName: "profileAvatar", fullName: "Surname Name")
    private static let bonusesSetting = ProfileSettingOption(title: "Bonuses", iconImageName: "star")
    private static let termsSetting = ProfileSettingOption(title: "Terms & Privacy Policy", iconImageName: "paper")
    private static let logoutSetting = ProfileSettingOption(title: "Log out", iconImageName: "logout")

    private(set) var profileInfo: ProfileInfo = profileInfoMock

    var profileTableCells: [ProfileCellType] {
        [
            .profile(profileInfo),
            .setting(ProfileConfiguration.bonusesSetting),
            .setting(ProfileConfiguration.termsSetting),
            .setting(ProfileConfiguration.logoutSetting)
        ]
    }

    mutating func updateFullName(_ fullName: String) {
        profileInfo.fullName = fullName
    }
}
