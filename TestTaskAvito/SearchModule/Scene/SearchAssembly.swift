//
//  SearchAssembly.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class SearchAssembly {
    static func build() -> UIViewController {
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(presenter: presenter)
        let view = SearchViewController(interactor: interactor)
        
        presenter.view = view
        return view
    }
}
