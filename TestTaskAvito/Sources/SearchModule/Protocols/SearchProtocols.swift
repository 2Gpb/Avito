//
//  SearchProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

protocol SearchBusinessLogic: UICollectionViewDataSource, UITableViewDataSource {
    func loadStart()
    func loadSelectCategory()
    func loadPriceSelector()
    func loadProductCard(for index: Int)
    func loadSearch(with title: String?)
    func loadSelectedQuery(with index: Int)
}

protocol SearchPresentationLogic {
    func presentStart(with title: String?, failedViewIsHidden: Bool)
    func presentFilters()
//    func presentClearSearch()
}

protocol SearchRouterLogic {
    func routeToProductCard(with model: ProductModel.Element)
    func routeToSelectCategory(
        completion: @escaping (Int, String) -> Void,
        currentCategoryId: Int?
    )
    
    func routeToPriceSelector(
        completion: @escaping (Int?, Int?) -> Void,
        currentMin: Int?,
        currentMax: Int?
    )
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
