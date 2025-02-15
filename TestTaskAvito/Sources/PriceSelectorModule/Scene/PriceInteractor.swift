//
//  PriceInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

final class PriceInteractor: PriceBusinessLogic {
    // MARK: - Private fields
    private let presenter: PricePresentationLogic & PriceRouterLogic
    
    // MARK: - Lifecycle
    init(presenter: PricePresentationLogic & PriceRouterLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func closeScreen() {
        presenter.dismissViewController()
    }
}
