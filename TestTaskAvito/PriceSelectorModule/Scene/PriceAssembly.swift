//
//  PriceAssembly.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class PriceAssembly {
    static func build() -> UIViewController {
        let presenter = PricePresenter()
        let interactor = PriceInteractor(presenter: presenter)
        let view = PriceViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
