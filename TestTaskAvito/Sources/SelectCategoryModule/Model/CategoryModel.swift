//
//  CategoryModel.swift
//  TestTaskAvito
//
//  Created by Peter on 15.02.2025.
//

typealias CategoriesResponse = [CategoryModel]

struct CategoryModel: Codable {
    let id: Int
    let name: String
}
