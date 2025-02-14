//
//  ProductCardPresebter.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class ProductCardPresenter: ProductCardPresentationLogic {
    // MARK: - Variables
    weak var view: ProductCardViewController?
    
    // MARK: - Methods
    func presentStart(with model: ProductModel.Element, number: Int) {
        let newModel = ProductCardModel(
            imageAddress: model.images[0],
            price: "\(model.price)$",
            title: model.title,
            description: model.description,
            category: model.category.name
        )
        
        view?.displayStart(model: newModel, number: number)
    }
    
    func present(number: Int) {
        view?.display(number: "\(number)")
    }
}

// MARK: - ProductCardRouterLogic
extension ProductCardPresenter: ProductCardRouterLogic {
    func popViewController() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func present(shareSheet: UIActivityViewController) {
        view?.present(shareSheet, animated: true)
    }
}
