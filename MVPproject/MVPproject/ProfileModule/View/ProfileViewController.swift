// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Профиль
final class ProfileViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let title = "Profile"
    }

    // MARK: - Visual Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(ProfileInfoCell.self, forCellReuseIdentifier: ProfileInfoCell.reuseID)
        tableView.register(ProfileSettingCell.self, forCellReuseIdentifier: ProfileSettingCell.reuseID)
        tableView.disableAutoresizingMask()
        return tableView
    }()

    // MARK: - Private Properties

    private let profileTableConfiguration = ProfileTableConfiguration()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupView()
    }

    // MARK: - Private Methods

    private func setupNavigationItem() {
        title = Constants.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.verdanaBold(ofSize: 28) ?? UIFont.boldSystemFont(ofSize: 28)
        ]
    }

    private func setupView() {
        view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - ProfileViewController + UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileTableConfiguration.profileTableCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableConfiguration.profileTableCells[indexPath.row]
        switch cell {
        case let .profile(profileInfo):
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: ProfileInfoCell.reuseID) as? ProfileInfoCell
            else { return .init() }
            cell.configureCell(profileInfo)
            return cell
        case let .setting(profileSetting):
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: ProfileSettingCell.reuseID) as? ProfileSettingCell
            else { return .init() }
            cell.configureCell(profileSetting)
            return cell
        }
    }
}
