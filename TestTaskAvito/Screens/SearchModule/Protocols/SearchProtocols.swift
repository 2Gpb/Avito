//
//  SearchProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

protocol SearchBusinessLogic {
    func loadStart()
    func loadSelectCategory()
    func loadPriceSelector()
    func loadProductCard()
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
    func routeToProductCard()
}

protocol ProductsWorker {
    func fetchProducts(
        for address: ProductModel.Address,
        completion: ((Result<ProductsResponse?, Error>) -> Void)?
    )
}
