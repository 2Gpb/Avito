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
}

protocol ProductCardPresentationLogic {
    
}

protocol ProductCardRouterLogic {
    func popViewController()
    func present(shareSheet: UIActivityViewController)
}
