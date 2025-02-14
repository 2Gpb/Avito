//
//  ShopingListAssembly.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

final class ShoppingListAssembly {
    static func build() -> UIViewController {
        let presenter = ShoppingListPresenter()
        let interactor = ShoppingListInteractor(presenter: presenter)
        let view = ShoppingListViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
