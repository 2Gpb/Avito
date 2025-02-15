//
//  PriceInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import Foundation

final class PriceInteractor: PriceBusinessLogic {
    // MARK: - Private fields
    private let presenter: PricePresentationLogic & PriceRouterLogic
    private let completion: (Int?, Int?) -> Void
    
    // MARK: - Lifecycle
    init(
        presenter: PricePresentationLogic & PriceRouterLogic,
        completion: @escaping (Int?, Int?) -> Void
    ) {
        self.presenter = presenter
        self.completion = completion
    }
    
    // MARK: - Methods
    func applyFilter(minPrice: Int?, maxPrice: Int?) {
        completion(minPrice, maxPrice)
        presenter.dismissViewController()
    }
    
    func closeScreen() {
        presenter.dismissViewController()
    }
}
