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
    func loadProducts(
        title: String?,
        priceMin: Int?,
        priceMax: Int?,
        categoryId: Int?
    )
}

protocol SearchPresentationLogic {
    func presentStart()
}

protocol SearchRouterLogic {
    func routeToSelectCategory()
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
