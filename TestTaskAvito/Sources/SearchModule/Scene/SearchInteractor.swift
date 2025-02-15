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
    
    // MARK: - Variables
    var filters: FiltersModel
    var products: ProductsResponse = []
    
    // MARK: - Lifecycle
    init(
        presenter: SearchPresentationLogic & SearchRouterLogic,
        service: ProductsWorker,
        filters: FiltersModel = FiltersModel()
    ) {
        self.presenter = presenter
        self.productsService = service
        self.filters = filters
    }
    
    // MARK: - Methods
    func loadStart() {
        refresh()
    }
    
    func loadSelectCategory() {
        presenter.routeToSelectCategory(completion: { [weak self] id, categoryName in
            self?.filters.categoryId = id
            self?.filters.categoryName = categoryName
            self?.presenter.presentFilters()
        }, currentCategoryId: filters.categoryId)
    }
    
    func loadPriceSelector() {
        presenter.routeToPriceSelector(completion: { [weak self] min, max in
            self?.filters.priceFrom = min
            self?.filters.priceTo = max
            self?.presenter.presentFilters()
        }, currentMin: filters.priceFrom, currentMax: filters.priceTo)
    }
    
    func loadProductCard(for index: Int) {
        presenter.routeToProductCard(with: products[index])
    }
    
    func loadSearch(with title: String?) {
        filters.title = title
        refresh()
    }
    
    func resetSearch() {
        filters.title = nil
        refresh()
    }
    
    // MARK: - Private fields
    private func refresh() {
        loadProducts(
            title: filters.title,
            priceMin: filters.priceFrom,
            priceMax: filters.priceTo,
            categoryId: filters.categoryId
        )
    }
    
    private func updateProducts(_ products: ProductsResponse) {
        self.products = products
        if self.products.isEmpty {
            presenter.presentStart(isHidden: false)
        } else {
            presenter.presentStart(isHidden: true)
        }
    }
    
    private func loadProducts(
        title: String? = nil,
        priceMin: Int? = nil,
        priceMax: Int? = nil,
        categoryId: Int? = nil
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
            
            cell.configure(category: filters.categoryName, min: filters.priceFrom, max: filters.priceTo)
            
            cell.openSelectCategory = { [weak self] in
                self?.loadSelectCategory()
            }
            
            cell.openPriceSelector = { [weak self] in
                self?.loadPriceSelector()
            }
            
            cell.showProducts = { [weak self] in
                self?.refresh()
            }
            
            cell.resetFilters = { [weak self] in
                self?.filters.categoryId = nil
                self?.filters.categoryName = nil
                self?.filters.priceFrom = nil
                self?.filters.priceTo = nil
                self?.refresh()
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
                price: "$\(products[indexPath.row].price)",
                imagePath: products[indexPath.row].images[0]
            )
            
            return cell
        }
    }
}
