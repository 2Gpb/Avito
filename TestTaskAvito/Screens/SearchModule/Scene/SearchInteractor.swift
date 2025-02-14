//
//  SearchInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

final class SearchInteractor: SearchBusinessLogic {
    // MARK: - Private fields
    private let presenter: SearchPresentationLogic & SearchRouterLogic
    private let productsService: ProductsWorker
    
    var products: [ProductsResponse]?
    
    // MARK: - Lifecycle
    init(presenter: SearchPresentationLogic & SearchRouterLogic, service: ProductsWorker) {
        self.presenter = presenter
        self.productsService = service
    }
    
    // MARK: - Methods
    func loadStart() {
        presenter.presentStart()
    }
    
    func loadSelectCategory() {
        presenter.routeToSelectCategory()
    }
    
    func loadPriceSelector() {
        presenter.routeToPriceSelector()
    }
    
    func loadProductCard() {
        presenter.routeToProductCard()
    }
    
    func loadProducts(
        title: String?,
        priceMin: Int?,
        priceMax: Int?,
        categoryId: Int?
    ) {
        productsService.fetchProducts(
            for: ProductModel.Address(
                title: title,
                priceMin: priceMin,
                priceMax: priceMax,
                categoryId: categoryId
            )
        ) { response in
            
            switch response {
            case .success(let products):
                products?.forEach({
                    print($0.title)
                })
            case .failure(let error):
                print(error)
            }
        }
    }
}
