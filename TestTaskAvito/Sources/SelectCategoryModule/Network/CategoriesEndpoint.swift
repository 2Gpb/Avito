//
//  CategoriesEndpoint.swift
//  TestTaskAvito
//
//  Created by Peter on 15.02.2025.
//

enum CategoryEndpoint: Endpoint {
    case Categories
    
    var compositePath: String {
        switch self {
        case .Categories:
            return "/api/v1/categories"
        }
    }
    
    var headers: [String : String] { [:] }
}
