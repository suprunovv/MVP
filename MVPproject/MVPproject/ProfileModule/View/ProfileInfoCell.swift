// ProfileInfoCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ProfileInfoCellDelegate: AnyObject {
    func editFullname()
}

/// Ячейка информации о профиле
final class ProfileInfoCell: UITableViewCell {
    var delegate: ProfileInfoCellDelegate?

    // MARK: - Constants

    private enum Constants {
        static let avatarImageSize = 160.0
        static let avatarImageCornerRadius = avatarImageSize / 2
        static let avatarImageBorderWidth = 3.0
        static let profileToCellTopSpacing = 36.0
        static let profileToCellBottomSpacing = 29.0
        static let fullNameToAvatarSpacing = 26.0
        static let fullNameToEditButtonSpacing = 8.0
        static let profileToViewWidthDifference = 100.0
    }

    static let reuseID = String(describing: ProfileInfoCell.self)

    // MARK: - Visual Components

    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.avatarImageCornerRadius
        view.layer.borderWidth = Constants.avatarImageBorderWidth
        view.layer.borderColor = UIColor.greenAccent.cgColor
        view.disableAutoresizingMask()
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: Constants.avatarImageSize),
            view.heightAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 25)
        label.textColor = .grayText
        label.disableAutoresizingMask()
        return label
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.pencil, for: .normal)
        button.tintColor = .grayText
        button.disableAutoresizingMask()
        button.addTarget(self, action: #selector(clickedEditButton), for: .touchUpInside)
        return button
    }()

    private lazy var profileStackView: UIStackView = {
        let nameStack = UIStackView(arrangedSubviews: [fullNameLabel, editButton])
        nameStack.axis = .horizontal
        nameStack.alignment = .center
        nameStack.spacing = Constants.fullNameToEditButtonSpacing
        let profileStack = UIStackView(arrangedSubviews: [profileImageView, nameStack])
        profileStack.axis = .vertical
        profileStack.spacing = Constants.fullNameToAvatarSpacing
        profileStack.alignment = .center
        profileStack.disableAutoresizingMask()
        return profileStack
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    // MARK: - Public Methods

    func configureCell(_ profileInfo: ProfileInfo) {
        profileImageView.image = UIImage(named: profileInfo.avatarImageName)
        fullNameLabel.text = profileInfo.fullName
    }

    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        contentView.addSubview(profileStackView)

        setupProfileStackViewConstraints()
    }

    private func setupProfileStackViewConstraints() {
        NSLayoutConstraint.activate([
            profileStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.profileToCellTopSpacing
            ),
            profileStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentView.widthAnchor.constraint(
                equalTo: profileStackView.widthAnchor,
                constant: Constants.profileToViewWidthDifference
            ),
            contentView.bottomAnchor.constraint(
                equalTo: profileStackView.bottomAnchor,
                constant: Constants.profileToCellBottomSpacing
            )
        ])
    }

    @objc private func clickedEditButton() {
        delegate?.editFullname()
    }
}

// Inside ProfileViewController class
extension ProfileViewController: ProfileInfoCellDelegate {
    func editFullname() {
        let alertController = UIAlertController(title: "Change Full Name", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Enter Full Name"
        }

        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            if let newName = alertController.textFields?.first?.text {
                if case var .profile(profileInfo) = self.profileTableConfiguration.profileTableCells[0] {
                    profileInfo.fullName = newName
                    self.profileTableConfiguration.profileTableCells[0] = .profile(profileInfo)

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(cancel)
        alertController.addAction(okAction)

        alertController.preferredAction = okAction

        present(alertController, animated: true, completion: nil)
    }
}
