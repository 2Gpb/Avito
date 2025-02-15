//
//  PriceProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

protocol PriceBusinessLogic {
    func applyFilter(minPrice: Int?, maxPrice: Int?)
    func closeScreen()
}

protocol PricePresentationLogic {
    
}

protocol PriceRouterLogic {
    func dismissViewController()
}
