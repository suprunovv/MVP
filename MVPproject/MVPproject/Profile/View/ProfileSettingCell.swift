// ProfileSettingCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ячейка настройки в профиле
final class ProfileSettingCell: UITableViewCell {
    static let reuseID = String(describing: ProfileSettingCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    func configureCell(_ profileSetting: ProfileSettingOption) {}

    private func setupCell() {}
}
