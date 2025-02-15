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
    private let productModel: ProductCardModel
    private let service: ProductCoreDataServiceLogic
    
    // MARK: - Lifecycle
    init(
        presenter: ProductCardPresentationLogic & ProductCardRouterLogic,
        model: ProductCardModel,
        service: ProductCoreDataServiceLogic
    ) {
        self.presenter = presenter
        self.productModel = model
        self.service = service
    }
    
    // MARK: - Methods
    func loadStart() {
        presenter.presentStart(
            with: productModel,
            number: service.getNumber(of: productModel.id)
        )
    }
    
    func addFirstNumber() {
        service.add(element: productModel)
        presenter.present(number: service.getNumber(of: productModel.id))
    }
    
    func increaseNumber() {
        service.increaseNumber(of: productModel.id)
        presenter.present(number: service.getNumber(of: productModel.id))
    }
    
    func decreaseNumber() {
        service.decreaseNumber(of: productModel.id)
        presenter.present(number: service.getNumber(of: productModel.id))
    }
    
    func goBack() {
        presenter.popViewController()
    }
    
    func shareProduct(shareSheet: UIActivityViewController) {
        presenter.present(shareSheet: shareSheet)
    }
}
