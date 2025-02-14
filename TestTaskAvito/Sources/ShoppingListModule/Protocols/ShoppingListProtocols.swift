//
//  ShopingListProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

protocol ShoppingListBusinessLogic {
    func loadStart()
    func shareCart(shareSheet: UIActivityViewController)
}

protocol ShoppingListPresentationLogic {
    func presentProducts()
}

protocol ShoppingListRouterLogic {
    func presentShareSheet(shareSheet: UIActivityViewController)
}

protocol ShoppingListCoreDataServiceLogic: CoreDataService {
    func getAllProducts() -> [Product]
}
