//
//  SelectCategoryProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

protocol CategoryBusinessLogic: UITableViewDataSource {
    func loadStart()
    func closeScreen()
    func selectedCategory(index: Int, deselectRow: (Int?) -> Void)
}

protocol CategoryPresentationLogic {
    func presentStart()
}

protocol CategoryRouterLogic {
    func dismissViewController()
}

protocol CategoryWorker {
    func fetchCategory(completion: ((Result<CategoriesResponse?, Error>) -> Void)?)
}

protocol CategoriesStorage {
    var categories: CategoriesResponse { get set }
}
