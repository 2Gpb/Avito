//
//  SearchProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

protocol SearchBusinessLogic {
    func loadStart()
    func loadSelectCategory()
    func loadPriceSelector()
    func loadProductCard()
}

protocol SearchPresentationLogic {
    func presentStart()
}

protocol SearchRouterLogic {
    func routeToSelectCategory()
    func routeToPriceSelector()
    func routeToProductCard()
}
