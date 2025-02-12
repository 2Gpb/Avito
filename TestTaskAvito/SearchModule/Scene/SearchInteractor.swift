//
//  SearchInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

final class SearchInteractor: SearchBusinessLogic {
    private let presenter: SearchPresentationLogic & SearchRouterLogic
    
    init(presenter: SearchPresentationLogic & SearchRouterLogic) {
        self.presenter = presenter
    }
    
    func loadStart() {
        presenter.presentStart()
    }
}
