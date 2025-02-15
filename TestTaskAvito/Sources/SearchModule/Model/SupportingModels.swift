//
//  SupportingModels.swift
//  TestTaskAvito
//
//  Created by Peter on 15.02.2025.
//

struct FiltersModel {
    var title: String?
    var categoryId: Int?
    var categoryName: String?
    var priceFrom: Int?
    var priceTo: Int?
}

enum CollectionSection: Int, CaseIterable {
    case filters
    case products
}
