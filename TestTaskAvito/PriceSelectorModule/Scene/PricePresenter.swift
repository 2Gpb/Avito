//
//  PricePresenter.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

final class PricePresenter: PricePresentationLogic {
    // MARK: - Variables
    weak var view: PriceViewController?
}

// MARK: - PriceRouterLogic
extension PricePresenter: PriceRouterLogic {
    func dismissViewController() {
        view?.dismiss(animated: true)
    }
}
