//
//  CategoryPresenter.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

final class CategoryPresenter:CategoryPresentationLogic {
    // MARK: - Variables
    weak var view: CategoryViewController?
}

// MARK: - CategoryRouterLogic
extension CategoryPresenter: CategoryRouterLogic {
    func dismissViewController() {
        view?.dismiss(animated: true)
    }
}
