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
    func presentShareSheet(_ shareItems: [String]) {
        let activityViewController: UIActivityViewController = UIActivityViewController(
            activityItems: shareItems,
            applicationActivities: nil
        )
        
        view?.present(activityViewController, animated: true)
    }
    
    func presentAlert(id: Int) {
        if let alert = view?.setUpAlert(id: id) {
            view?.present(alert, animated: true)
        }
    }
    
    func presentProductCard(with model: ShoppingListItemModel) {
        view?.navigationController?.pushViewController(
            ProductCardAssembly.build(
                with: ProductCardModel(
                    id: model.id,
                    imageAddress: model.image,
                    price: model.price,
                    title: model.name,
                    description: model.description,
                    category: model.category
                )
            ), animated: true
        )
    }
}
