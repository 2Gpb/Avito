//
//  SearchInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

final class SearchInteractor: SearchBusinessLogic {
    // MARK: - Private fields
    private let presenter: SearchPresentationLogic & SearchRouterLogic
    
    // MARK: - Lifecycle
    init(presenter: SearchPresentationLogic & SearchRouterLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadStart() {
        presenter.presentStart()
    }
    
    func loadSelectCategory() {
        presenter.routeToSelectCategory()
    }
}
