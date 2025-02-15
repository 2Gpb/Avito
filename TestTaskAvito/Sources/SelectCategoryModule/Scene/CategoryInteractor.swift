//
//  CategoryInteractor.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

final class CategoryInteractor: CategoryBusinessLogic {
    // MARK: - Private fields
    private let presenter: CategoryPresentationLogic & CategoryRouterLogic
    
    // MARK: - Lifecycle
    init(presenter: CategoryPresentationLogic & CategoryRouterLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func closeScreen() {
        presenter.dismissViewController()
    }
}
