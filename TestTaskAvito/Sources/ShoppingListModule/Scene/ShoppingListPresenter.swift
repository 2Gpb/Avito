//
//  ShopingListPresenter.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

final class ShoppingListPresenter: ShoppingListPresentationLogic {
    func presentProducts() {
        <#code#>
    }
    
    // MARK: - Variables
    weak var view: ShoppingListViewController?
}

// MARK: - RouterLogic
extension ShoppingListPresenter: ShoppingListRouterLogic {
    func presentShareSheet(shareSheet: UIActivityViewController) {
        view?.present(shareSheet, animated: true)
    }
}
