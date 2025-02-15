//
//  ProductCardAssembly.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class ProductCardAssembly {
    static func build(with model: ProductCardModel) -> UIViewController {
        let service: ProductCoreDataServiceLogic = ProductCoreDataService()
        let presenter = ProductCardPresenter()
        let interactor = ProductCardInteractor(presenter: presenter, model: model, service: service)
        let view = ProductCardViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
