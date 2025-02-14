//
//  SearchService.swift
//  TestTaskAvito
//
//  Created by Peter on 14.02.2025.
//

import Foundation

final class SearchService: ProductsWorker {
    //
    private let networking: NetworkingLogic
    private let decoder: JSONDecoder = JSONDecoder()
    
    //
    init(networking: NetworkingLogic) {
        self.networking = networking
    }
    
    func fetchProducts(
        for address: ProductModel.Address,
        completion: ((Result<ProductsResponse?, Error>) -> Void)?
    ) {
        let endpoint =  SearchEndpoint.products(
            title: address.title,
            priceMin: address.priceMin,
            priceMax: address.priceMax,
            categoryId: address.categoryId
        )
        
        fetch(request: Request(endpoint: endpoint), completion: completion)
    }
    
    private func fetch<T: Decodable>(
        request: Request,
        completion: ((Result<T?, Error>) -> Void)?
    ) {
        networking.execute(with: request) { [weak self] response in
            switch response {
            case .success(let serverResponse):
                guard
                    let self,
                    let data = serverResponse.data
                else {
                    // Idealy we create custom error enum
                    completion?(.success(nil))
                    return
                }

                do {
                    let decoded = try self.decoder.decode(T.self, from: data)
                    completion?(.success(decoded))
                } catch(let error) {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
