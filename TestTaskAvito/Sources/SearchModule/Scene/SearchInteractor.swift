//
//  SearchInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class SearchInteractor: NSObject, SearchBusinessLogic & ProductStorage {
    // MARK: - Private fields
    private let presenter: SearchPresentationLogic & SearchRouterLogic
    private let productsService: ProductsWorker
    
    var products: ProductsResponse = []
    
    private enum CollectionSection: Int, CaseIterable {
        case filters
        case products
    }
    
    // MARK: - Lifecycle
    init(presenter: SearchPresentationLogic & SearchRouterLogic, service: ProductsWorker) {
        self.presenter = presenter
        self.productsService = service
    }
    
    // MARK: - Methods
    func loadStart() {
        loadProducts(title: nil, priceMin: nil, priceMax: nil, categoryId: nil)
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
        ) { [weak self] response in
            switch response {
            case .success(let products):
                self?.updateProducts(products ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateProducts(_ products: ProductsResponse) {
        self.products = products
        presenter.presentStart()
    }
}


// MARK: - UICollectionViewDataSource
extension SearchInteractor: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        CollectionSection.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let section = CollectionSection.allCases[section]
        
        switch section {
        case .filters:
            return 1
        case .products:
            return products.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let section = CollectionSection.allCases[indexPath.section]
        
        switch section {
        case .filters:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FiltersViewCell.reuseId,
                for: indexPath
            ) as? FiltersViewCell else {
                return UICollectionViewCell()
            }
            
            cell.openSelectCategory = { [weak self] in
                self?.loadSelectCategory()
            }
            
            cell.openPriceSelector = { [weak self] in
                self?.loadPriceSelector()
            }
            
            return cell
        case .products:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductViewCell.reuseId,
                for: indexPath
            ) as? ProductViewCell else {
                return UICollectionViewCell()
            }

            cell.configure(
                name: products[indexPath.row].title,
                price: "\(products[indexPath.row].price)$",
                imagePath: products[indexPath.row].images[0]
            )
            
            return cell
        }
    }
}
