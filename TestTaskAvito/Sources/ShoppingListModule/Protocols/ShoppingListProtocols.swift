//
//  ShopingListProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

protocol ShoppingListBusinessLogic: UICollectionViewDataSource {
    func loadStart()
    func shareCart()
    func clearCart()
    func deleteProduct(at id: Int)
    func loadProductCard(for index: Int)
}

protocol ShoppingListPresentationLogic {
    func presentProducts(emptyState: Bool)
    func presentAlert(id: Int)
    func presentShareSheet(_ shareSheet: [String])
}

protocol ShoppingListRouterLogic {
    func presentProductCard(with model: ShoppingListItemModel)
}

protocol ShoppingListDataStore {
    var products: [ShoppingListItemModel] { get set }
}

protocol ShoppingListCoreDataServiceLogic: CoreDataService {
    func getAllProducts() -> [Product]
    func deleteAll()
}
