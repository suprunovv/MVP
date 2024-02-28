// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

//
//  ProfilePresenter.swift
//  MVPproject
//
//  Created by Қадыр Маратұлы on 28.02.2024.
//
import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    var profileCoordinator: ProfileCoordinator? { get set }

    // func editFullname(fullName: String)
}

protocol ProfileViewProtocol: AnyObject {
    func showBottomSheet()
}

final class ProfilePresenter {
    weak var profileCoordinator: ProfileCoordinator? // Это простой делагат
    // Обязательно weak , а то у нас будет сильная зависемость

    private weak var view: ProfileViewProtocol?

    init(view: ProfileViewProtocol) {
        self.view = view
    }
}

// Реализуем или предаем как понял команду для вью
extension ProfilePresenter: ProfilePresenterProtocol {
//    func editFullname(fullName: String) {
//
//    }

    func clickedBonusButton() {
        view?.showBottomSheet()
    }
}
