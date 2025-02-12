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
}

protocol SearchPresentationLogic {
    func presentStart()
}

protocol SearchRouterLogic {
    func routeToSelectCategory()
    func routeToPriceSelector()
}
