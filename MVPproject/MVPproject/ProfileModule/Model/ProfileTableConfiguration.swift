// ProfileTableConfiguration.swift
// Copyright © RoadMap. All rights reserved.

/// Кнфигурация таблицы на экране профиля
struct ProfileTableConfiguration {
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

    let profileTableCells: [ProfileCellType] = [
        .profile(ProfileTableConfiguration.profileInfoMock),
        .setting(bonusesSetting),
        .setting(termsSetting),
        .setting(logoutSetting)
    ]
}
