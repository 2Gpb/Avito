//
//  ShopingListInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

final class ShoppingListInteractor: ShoppingListBusinessLogic {
    // MARK: - Private fields
    private let presenter: ShoppingListPresentationLogic & ShoppingListRouterLogic
    
    // MARK: - Lifecycle
    init(presenter: ShoppingListPresentationLogic & ShoppingListRouterLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func shareCart(shareSheet: UIActivityViewController) {
        presenter.presentShareSheet(shareSheet: shareSheet)
    }
}
