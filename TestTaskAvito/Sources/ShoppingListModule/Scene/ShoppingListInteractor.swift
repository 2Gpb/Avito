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
    private let service: ShoppingListCoreDataServiceLogic
    
    // MARK: - Lifecycle
    init(presenter: ShoppingListPresentationLogic & ShoppingListRouterLogic, service: ShoppingListCoreDataServiceLogic) {
        self.presenter = presenter
        self.service = service
    }
    
    func loadStart() {
        <#code#>
    }
    
    // MARK: - Methods
    func shareCart(shareSheet: UIActivityViewController) {
        presenter.presentShareSheet(shareSheet: shareSheet)
    }
}
