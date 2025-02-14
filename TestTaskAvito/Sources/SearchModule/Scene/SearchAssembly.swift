//
//  SearchAssembly.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class SearchAssembly {
    static func build() -> UIViewController {
        let worker = BaseURLWorker(baseUrl: "https://api.escuelajs.co")
        let service = SearchService(networking: worker)
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(presenter: presenter, service: service)
        let view = SearchViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
