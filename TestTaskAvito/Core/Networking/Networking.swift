//
//  Networking.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import Foundation

protocol NetworkingLogic {
    typealias Response = ((_ response: Result<Networking.ServerResponse, Error>) -> Void)
    
    func execute(with request: Request, completion: @escaping Response)
}

enum Networking {
    struct ServerResponse {
        let data: Data?
        let response: URLResponse?
    }
}

final class BaseURLWorker: NetworkingLogic {
    // MARK: - Error
    enum BaseURLError: Error {
        case invalidRequest
    }
    
    // MARK: - Variables
    var baseUrl: String
    
    // MARK: - Lifecycle
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    // MARK: - Methods
    func execute(with request: Request, completion: @escaping Response) {
        guard let urlRequest = convert(request) else {
            completion(.failure(BaseURLError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            completion(.success(Networking.ServerResponse(data: data, response: response)))
        }
        
        task.resume()
    }
    
    // MARK: - Private fields
    private func convert(_ request: Request) -> URLRequest? {
        guard let url = generateDestinationURL(for: request) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.endpoint.headers
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = request.timeInterval
        
        return urlRequest
    }
    
    private func generateDestinationURL(for request: Request) -> URL? {
        guard
            let url = URL(string: baseUrl),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else {
            return nil
        }
        
        let queryItems = request.parameters?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        components.path += request.endpoint.compositePath
        components.queryItems = queryItems
        
        return components.url
    }
}
