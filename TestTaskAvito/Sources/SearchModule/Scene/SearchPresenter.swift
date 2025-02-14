//
//  SearchPresenter.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import Foundation

final class SearchPresenter: SearchPresentationLogic {
    // MARK: - Variables
    weak var view: SearchViewController?
    
    // MARK: - Methods
    func presentStart() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayStart()
        }
    }
}

// MARK: - SearchRouterLogic
extension SearchPresenter: SearchRouterLogic {
    func routeToSelectCategory() {
        let bottomSheetVC = CategoryAssembly.build()
        bottomSheetVC.modalPresentationStyle = .pageSheet
        view?.present(bottomSheetVC, animated: true)
    }
    
    func routeToPriceSelector() {
        let bottomSheetVC = PriceAssembly.build()
        bottomSheetVC.modalPresentationStyle = .pageSheet
        view?.present(bottomSheetVC, animated: true)
    }
    
    func routeToProductCard() {
        view?.navigationController?.pushViewController(ProductCardAssembly.build(), animated: true)
    }
}
