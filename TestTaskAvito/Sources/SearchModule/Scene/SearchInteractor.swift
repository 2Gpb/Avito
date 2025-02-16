//
//  SearchInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class SearchInteractor: NSObject, SearchBusinessLogic & ProductStorage {
    // MARK: - Variables
    private(set) var filters: FiltersModel
    var products: ProductsResponse = []
    
    // MARK: - Private fields
    private let presenter: SearchPresentationLogic & SearchRouterLogic
    private let productsService: ProductsWorker
    private let storageService: UserDefaultsLogic
    
    // MARK: - Lifecycle
    init(
        presenter: SearchPresentationLogic & SearchRouterLogic,
        service: ProductsWorker,
        storage: UserDefaultsLogic = UserDefaultsService(),
        filters: FiltersModel = FiltersModel()
    ) {
        self.presenter = presenter
        self.productsService = service
        self.filters = filters
        self.storageService = storage
    }
    
    // MARK: - Methods
    func loadStart() {
        refresh()
    }
    
    func loadProductCard(for index: Int) {
        presenter.routeToProductCard(with: products[index])
    }
    
    func loadSearch(with title: String?) {
        if let title = title, !title.isEmpty {
            var history: [String] = storageService.get(
                forKey: UserDefaultsKeys.history.rawValue,
                defaultValue: []
            )
            
            history.removeAll { $0 == title }
            history.insert(title, at: 0)
            if history.count > 7 {
                history.removeLast()
            }

            storageService.set(
                value: history,
                forKey: UserDefaultsKeys.history.rawValue
            )
        }
        
        filters.title = title
        refresh()
    }
    
    func loadSelectedQuery(with index: Int) {
        let history = storageService.get(forKey: UserDefaultsKeys.history.rawValue, defaultValue: [""])
        filters.title = history[index]
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
    
    // MARK: - Private fields
    private func refresh() {
        loadProducts(
            title: filters.title,
            priceMin: filters.priceFrom,
            priceMax: filters.priceTo,
            categoryId: filters.categoryId
        )
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
            case .failure(_):
                self?.presenter.presentStart(
                    with: self?.filters.title ?? "",
                    errorState: true,
                    emptyState: false
                )
            }
        }
    }
    
    private func updateProducts(_ products: ProductsResponse) {
        self.products = products
        if self.products.isEmpty {
            presenter.presentStart(
                with: filters.title ?? "",
                errorState: false,
                emptyState: true
            )
        } else {
            presenter.presentStart(
                with: filters.title ?? "",
                errorState: false,
                emptyState: false
            )
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
                self?.filters.title = nil
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

// MARK: - UITableViewDataSource
extension SearchInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let history = storageService.get(forKey: UserDefaultsKeys.history.rawValue, defaultValue: [])
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchQueryCell.reuseId
        ) as? SearchQueryCell else {
            return UITableViewCell()
        }
        
        let history: [String] = storageService.get(
            forKey: UserDefaultsKeys.history.rawValue,
            defaultValue: []
        )
        
        cell.configure(query: history[indexPath.row])
        return cell
    }
}
