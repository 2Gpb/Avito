//
//  Endpoint.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import Foundation

protocol Endpoint {
    var compositePath: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String]? { get }
}

extension Endpoint {
    var parameters: [String: String]? {
        return nil
    }
}
