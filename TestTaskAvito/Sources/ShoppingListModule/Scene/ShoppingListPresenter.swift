//
//  ShopingListPresenter.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

final class ShoppingListPresenter: ShoppingListPresentationLogic {
    // MARK: - Variables
    weak var view: ShoppingListViewController?
    
    func presentProducts() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayStart()
        }
    }
}

// MARK: - RouterLogic
extension ShoppingListPresenter: ShoppingListRouterLogic {
    func presentShareSheet(shareSheet: UIActivityViewController) {
        view?.present(shareSheet, animated: true)
    }
}
