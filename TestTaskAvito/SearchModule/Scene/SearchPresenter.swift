//
//  SearchPresenter.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

final class SearchPresenter: SearchPresentationLogic {
    weak var view: SearchViewController?
    
    func presentStart() {
        view?.displayStart()
    }
}

extension SearchPresenter: SearchRouterLogic {
    
}
