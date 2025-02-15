//
//  CategoryPresenter.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import Foundation

final class CategoryPresenter:CategoryPresentationLogic {
    // MARK: - Variables
    weak var view: CategoryViewController?
    
    // MARK: - Methods
    func presentStart() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayStart()
        }
    }
}

// MARK: - CategoryRouterLogic
extension CategoryPresenter: CategoryRouterLogic {
    func dismissViewController() {
        view?.dismiss(animated: true)
    }
}
