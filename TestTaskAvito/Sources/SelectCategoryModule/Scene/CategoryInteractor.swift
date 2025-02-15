//
//  CategoryInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit
import Foundation

final class CategoryInteractor: NSObject, CategoryBusinessLogic, CategoriesStorage {
    // MARK: - Private fields
    private let presenter: CategoryPresentationLogic & CategoryRouterLogic
    private let categoryService: CategoryWorker
    private let completion: (Int, String) -> Void
    private let currentCategoryId: Int?
    
    // MARK: - Variables
    var categories: CategoriesResponse = []
    
    // MARK: - Lifecycle
    init(
        presenter: CategoryPresentationLogic & CategoryRouterLogic,
        service: CategoryWorker,
        completion: @escaping (Int, String) -> Void,
        categoryId: Int?
    ) {
        self.presenter = presenter
        self.categoryService = service
        self.completion = completion
        self.currentCategoryId = categoryId
    }
    
    // MARK: - Methods
    func loadStart() {
        categoryService.fetchCategory { [weak self] response in
            switch response  {
            case .success(let categories):
                self?.categories = categories ?? []
                self?.presenter.presentStart()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func closeScreen() {
        presenter.dismissViewController()
    }
    
    func selectedCategory(index: Int, deselectRow: (Int?) -> Void) {
        deselectRow(categories.firstIndex(where: { category in
            category.id == currentCategoryId
        }))
        
        self.completion(categories[index].id, categories[index].name)
        presenter.dismissViewController()
    }
}

// MARK: - UITableViewDataSource
extension CategoryInteractor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryCell.reuseId
        ) as? CategoryCell else {
            return UITableViewCell()
        }
        
        if categories[indexPath.item].id == currentCategoryId {
            cell.showCheckImage()
        }
        
        cell.configure(text: categories[indexPath.row].name)
        return cell
    }
}
