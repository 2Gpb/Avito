//
//  SearchEndpoint.swift
//  TestTaskAvito
//
//  Created by Peter on 14.02.2025.
//

enum SearchEndpoint: Endpoint {
    case products(
        title: String?,
        priceMin: Int?,
        priceMax: Int?,
        categoryId: Int?
    )
    
    var compositePath: String {
        switch self {
        case .products:
            return "/api/v1/products"
        }
    }
    
    var headers: [String : String] { [:] }
    
    var parameters: [String : String]? {
        var result: [String : String] = [:]
        switch self {
        case .products(let title, let priceMin, let priceMax, let categoryId):
            if let title = title {
                result["title"] = title
            }
            
            if let priceMin = priceMin {
                result["price_min"] = "\(priceMin)"
            }
            
            if let priceMax = priceMax {
                result["price_max"] = "\(priceMax)"
            }
            
            if let categoryId = categoryId {
                result["category_id"] = "\(categoryId)"
            }
            
            return result
        }
    }
}
