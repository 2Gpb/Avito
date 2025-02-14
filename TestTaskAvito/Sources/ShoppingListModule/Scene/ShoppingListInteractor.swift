//
//  ShopingListInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

final class ShoppingListInteractor: NSObject, ShoppingListBusinessLogic & ShoppingListDataStore {
    // MARK: - Private fields
    private let presenter: ShoppingListPresentationLogic & ShoppingListRouterLogic
    private let service: ShoppingListCoreDataServiceLogic
    
    var products: [ShoppingListItemModel] = []
    
    // MARK: - Lifecycle
    init(presenter: ShoppingListPresentationLogic & ShoppingListRouterLogic, service: ShoppingListCoreDataServiceLogic) {
        self.presenter = presenter
        self.service = service
    }
    
    // MARK: - Methods
    func loadStart() {
        let products = service.getAllProducts()
        self.products = []
        for product in products {
            self.products.append(
                ShoppingListItemModel(
                    id: Int(product.id),
                    image: product.imageAddress ?? "",
                    name: product.title ?? "",
                    price: product.price ?? "",
                    count: Int(product.number)
                )
            )
        }
    
        presenter.presentProducts()
    }
    
    func refresh() {
        presenter.presentProducts()
    }
    
    func clearCart() {
        service.deleteAll()
        products.removeAll()
        presenter.presentProducts()
    }
    
    func shareCart(shareSheet: UIActivityViewController) {
        presenter.presentShareSheet(shareSheet: shareSheet)
    }
}

// MARK: - UICollectionViewDataSource
extension ShoppingListInteractor: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        products.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ShoppingListCell.reuseId,
            for: indexPath
        ) as? ShoppingListCell else {
            return UICollectionViewCell()
        }
        
        cell.minusTapped = { [weak self] in
            let productId = self?.products[indexPath.item].id
            self?.service.decreaseNumber(of: productId ?? 0)
            cell.setCount(self?.service.getNumber(of: productId ?? 0) ?? 0)
        }
        
        cell.plusTapped = { [weak self] in
            let productId = self?.products[indexPath.item].id
            self?.service.increaseNumber(of: productId ?? 0)
            cell.setCount(self?.service.getNumber(of: productId ?? 0) ?? 0)
        }
        
        cell.configure(with: products[indexPath.item])
        return cell
    }
}
