//
//  CategoryAssembly.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class CategoryAssembly {
    static func build() -> UIViewController {
        let presenter = CategoryPresenter()
        let interactor = CategoryInteractor(presenter: presenter)
        let view = CategoryViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
