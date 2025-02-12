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
    
    // MARK: - Lifecycle
    init(presenter: ProductCardPresentationLogic & ProductCardRouterLogic) {
        self.presenter = presenter
    }
    
    func goBack() {
        presenter.popViewController()
    }
    
    func shareProduct(shareSheet: UIActivityViewController) {
        presenter.present(shareSheet: shareSheet)
    }
}
