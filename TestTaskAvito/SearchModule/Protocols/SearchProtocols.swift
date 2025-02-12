//
//  SearchProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

protocol SearchBusinessLogic {
    func loadStart()
    func loadSelectCategory()
}

protocol SearchPresentationLogic {
    func presentStart()
}

protocol SearchRouterLogic {
    func routeToSelectCategory()
}
