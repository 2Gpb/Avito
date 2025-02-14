//
//  ProductCardInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class ProductCardInteractor: ProductCardBusinessLogic {
    // MARK: - Private fields
    private let presenter: ProductCardPresentationLogic & ProductCardRouterLogic
    private let productModel: ProductModel.Element
    
    // MARK: - Lifecycle
    init(presenter: ProductCardPresentationLogic & ProductCardRouterLogic, model: ProductModel.Element) {
        self.presenter = presenter
        self.productModel = model
    }
    
    // MARK: - Methods
    func loadStart() {
        presenter.presentStart(model: productModel)
    }
    
    func goBack() {
        presenter.popViewController()
    }
    
    func shareProduct(shareSheet: UIActivityViewController) {
        presenter.present(shareSheet: shareSheet)
    }
}
