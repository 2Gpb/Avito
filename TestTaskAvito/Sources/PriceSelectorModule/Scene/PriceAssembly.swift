//
//  PriceAssembly.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class PriceAssembly {
    static func build(
        completion: @escaping (Int?, Int?) -> Void,
        currentMin: Int?,
        currentMax: Int?
    ) -> UIViewController {
        let presenter = PricePresenter()
        let interactor = PriceInteractor(presenter: presenter, completion: completion)
        let view = PriceViewController(interactor: interactor, priceMin: currentMin, priceMax: currentMax)
        
        presenter.view = view
        return view
    }
}
