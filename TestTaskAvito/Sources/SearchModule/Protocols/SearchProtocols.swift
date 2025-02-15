//
//  SearchProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

protocol SearchBusinessLogic: UICollectionViewDataSource {
    func loadStart()
    func loadSelectCategory()
    func loadPriceSelector()
    func loadProductCard(for index: Int)
}

protocol SearchPresentationLogic {
    func presentStart()
    func presentFilters()
}

protocol SearchRouterLogic {
    func routeToSelectCategory(completion: @escaping (Int, String) -> Void, currentCategoryId: Int?)
    func routeToPriceSelector()
    func routeToProductCard(with model: ProductModel.Element)
}

protocol ProductsWorker {
    func fetchProducts(
        for address: ProductModel.Address,
        completion: ((Result<ProductsResponse?, Error>) -> Void)?
    )
}

protocol ProductStorage {
    var products: ProductsResponse { get set }
}
