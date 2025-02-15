//
//  CategoryAssembly.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class CategoryAssembly {
    static func build(completion: @escaping (Int, String) -> Void, categoryId: Int?) -> UIViewController {
        let worker = BaseURLWorker(baseUrl: "https://api.escuelajs.co")
        let service = CategoryService(networking: worker)
        let presenter = CategoryPresenter()
        let interactor = CategoryInteractor(
            presenter: presenter,
            service: service,
            completion: completion,
            categoryId: categoryId
        )
        
        let view = CategoryViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
