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
    
    func presentFilters() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayFilters()
        }
    }
}

// MARK: - SearchRouterLogic
extension SearchPresenter: SearchRouterLogic {
    func routeToSelectCategory(
        completion: @escaping (Int,String) -> Void,
        currentCategoryId: Int?
    ) {
        let bottomSheetVC = CategoryAssembly.build(
            completion: completion,
            categoryId: currentCategoryId
        )
        
        bottomSheetVC.modalPresentationStyle = .pageSheet
        view?.present(bottomSheetVC, animated: true)
    }
    
    func routeToPriceSelector(
        completion: @escaping (Int?,Int?) -> Void,
        currentMin: Int?,
        currentMax: Int?
    ) {
        let bottomSheetVC = PriceAssembly.build(
            completion: completion,
            currentMin: currentMin,
            currentMax: currentMax
        )
        
        bottomSheetVC.modalPresentationStyle = .pageSheet
        view?.present(bottomSheetVC, animated: true)
    }
    
    func routeToProductCard(with model: ProductModel.Element) {
        view?.navigationController?.pushViewController(
            ProductCardAssembly.build(
                with: ProductCardModel(
                    id: model.id,
                    imageAddress: model.images[0],
                    price: "$\(model.price)",
                    title: model.title,
                    description: model.description,
                    category: model.category.name
                )
            ), animated: true
        )
    }
}
