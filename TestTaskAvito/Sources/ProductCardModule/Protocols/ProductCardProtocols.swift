//
//  ProductCardProtocols.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

protocol ProductCardBusinessLogic {
    func goBack()
    func shareProduct(shareSheet: UIActivityViewController)
    func loadStart()
    func addFirstNumber()
    func increaseNumber()
    func decreaseNumber()
}

protocol ProductCardPresentationLogic {
    func present(shareSheet: UIActivityViewController)
    func presentStart(with model: ProductModel.Element, number: Int)
    func present(number: Int)
}

protocol ProductCardRouterLogic {
    func popViewController()
}

protocol ProductCoreDataServiceLogic: CoreDataService {
    func add(element: ProductModel.Element)
    func getNumber(of id: Int) -> Int
}
