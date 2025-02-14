//
//  ShopingListProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

protocol ShoppingListBusinessLogic {
    func shareCart(shareSheet: UIActivityViewController)
}

protocol ShoppingListPresentationLogic {
    
}

protocol ShoppingListRouterLogic {
    func presentShareSheet(shareSheet: UIActivityViewController)
}
