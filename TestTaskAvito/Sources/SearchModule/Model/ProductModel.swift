//
//  ItemModels.swift
//  TestTaskAvito
//
//  Created by Peter on 14.02.2025.
//

import Foundation

typealias ProductsResponse = [ProductModel.Element]

enum ProductModel {
    struct Element: Codable {
        let id: Int
        let title: String
        let price: Int
        let description: String
        let images: [String]
        let creationAt, updatedAt: String
        let category: Category
    }
    
    struct Category: Codable {
        let id: Int
        let name: String
        let image: String
    }
    
    struct Address {
        let title: String?
        let priceMin: Int?
        let priceMax: Int?
        let categoryId: Int?
    }
}
