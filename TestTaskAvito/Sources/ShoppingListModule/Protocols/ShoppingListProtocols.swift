//
//  ShopingListProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

protocol ShoppingListBusinessLogic: UICollectionViewDataSource {
    func loadStart()
    func shareCart(shareSheet: UIActivityViewController)
    func refresh()
    func clearCart()
}

protocol ShoppingListPresentationLogic {
    func presentProducts()
}

protocol ShoppingListRouterLogic {
    func presentShareSheet(shareSheet: UIActivityViewController)
}

protocol ShoppingListDataStore {
    var products: [ShoppingListItemModel] { get set }
}

protocol ShoppingListCoreDataServiceLogic: CoreDataService {
    func getAllProducts() -> [Product]
    func deleteAll()
}
