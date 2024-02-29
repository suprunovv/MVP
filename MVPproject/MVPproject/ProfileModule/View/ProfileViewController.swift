// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// протокол представления профиля
protocol ProfileViewProtocol: AnyObject {
    /// Обновление страницы пофиля
    func updateProfile(profileCells: ProfileConfiguration.ProfileCells)
    /// Вывод UI для изменения имени
    func showNameEdit(title: String, currentName: String)
}

/// Профиль
final class ProfileViewController: UIViewController {
    // MARK: - Types

    typealias ProfileCells = ProfileConfiguration.ProfileCells

    // MARK: - Constants

    private enum Constants {
        static let title = "Profile"
        static let cancelEditNameButtonText = "Cancel"
        static let submitEditNameButtonText = "Ok"
        static let editNameTextFieldPlaceholder = "Name Surname"
    }

    // MARK: - Visual Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileInfoCell.self, forCellReuseIdentifier: ProfileInfoCell.reuseID)
        tableView.register(ProfileSettingCell.self, forCellReuseIdentifier: ProfileSettingCell.reuseID)
        tableView.disableAutoresizingMask()
        return tableView
    }()

    private lazy var editNameAlert: UIAlertController = {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let submitHandler: (UIAlertAction) -> Void = { [weak self, weak alert] _ in
            if let updatedName = alert?.textFields?[0].text {
                self?.presenter?.handleNameChanged(updatedName)
            }
        }
        alert.addTextField { $0.placeholder = Constants.editNameTextFieldPlaceholder }
        let cancelAction = UIAlertAction(title: Constants.cancelEditNameButtonText, style: .cancel)
        let submitAction = UIAlertAction(
            title: Constants.submitEditNameButtonText,
            style: .default,
            handler: submitHandler
        )
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        alert.preferredAction = submitAction
        return alert
    }()

    // MARK: - Public Properties

    var presenter: ProfilePresenter?

    // MARK: - Private Properties

    private var profileCells: ProfileCells = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupView()
        presenter?.refreshProfileData()
    }

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
        profileCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileCells[indexPath.row]
        switch cell {
        case let .profile(profileInfo):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoCell.reuseID) as? ProfileInfoCell
            else { return .init() }
            cell.delegate = self
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

// MARK: - ProfileViewController + UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = profileCells[indexPath.row]
        switch cell {
        case let .setting(profileSetting):
            presenter?.settingSelected(profileSetting.type)
        default:
            break
        }
    }
}

// MARK: - ProfileViewController + ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func showNameEdit(title: String, currentName: String) {
        guard let nameTextField = editNameAlert.textFields?[0] else { return }
        editNameAlert.title = title
        nameTextField.text = currentName
        present(editNameAlert, animated: true)
    }

    func updateProfile(profileCells: ProfileCells) {
        self.profileCells = profileCells
        tableView.reloadData()
    }
}

// MARK: - ProfileViewController + ProfileInfoCellDelegate

extension ProfileViewController: ProfileInfoCellDelegate {
    func editNameButtonTapped() {
        presenter?.editNameButtonTapped()
    }
}
