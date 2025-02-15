//
//  CategoriesService.swift
//  TestTaskAvito
//
//  Created by Peter on 15.02.2025.
//

import Foundation

final class CategoryService: CategoryWorker {
    // MARK: - Private fields
    private let networking: NetworkingLogic
    private let decoder: JSONDecoder = JSONDecoder()
    
    // MARK: - Lifecycle
    init(networking: NetworkingLogic) {
        self.networking = networking
    }
    
    // MARK: - Methods
    func fetchCategory(
        completion: ((Result<CategoriesResponse?, any Error>) -> Void)?
    ) {
        let endpoint = CategoryEndpoint.Categories
        
        fetch(request: Request(endpoint: endpoint), completion: completion)
    }
    
    // MARK: - Private fields
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
