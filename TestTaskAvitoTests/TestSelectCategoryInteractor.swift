//
//  TestSelectCategoryInteractor.swift
//  TestTaskAvitoTests
//
//  Created by Peter on 16.02.2025.
//

import XCTest
@testable import TestTaskAvito

final class TestSelectCategoryInteractor: XCTestCase {
    private var interactor: CategoryInteractor!
    private var presenterMock: CategoryPresenterMock!
    private var serviceMock: CategoryServiceMock!
    private var completionMock: CategoryCompletionMock!
    private var completionCalled: Bool = false
    private var receivedCategoryId: Int?
    private var receivedCategoryName: String?

    override func setUpWithError() throws {
        try super.setUpWithError()
        presenterMock = CategoryPresenterMock()
        serviceMock = CategoryServiceMock()
        completionMock = CategoryCompletionMock()
        interactor = CategoryInteractor(
            presenter: presenterMock,
            service: serviceMock,
            completion: completionMock.completion,
            categoryId: 1
        )
    }

    override func tearDownWithError() throws {
        presenterMock = nil
        serviceMock = nil
        completionMock = nil
        interactor = nil
        try super.tearDownWithError()
    }
    
    func testLoadStartSuccess() {
        let mockCategories = [CategoryModel(id: 1, name: "test")]
        serviceMock.fetchCategoryResult = .success(mockCategories)
        
        interactor.loadStart()
        
        XCTAssertTrue(presenterMock.presentStartCalled)
    }
    
    func testLoadStartFailure() {
        serviceMock.fetchCategoryResult = .failure(NSError(domain: "", code: -1, userInfo: nil))
        
        interactor.loadStart()
        
        XCTAssertFalse(presenterMock.presentStartCalled)
    }
    
    func testCloseScreen() {
        interactor.closeScreen()
        
        XCTAssertTrue(presenterMock.dismissViewControllerCalled)
    }
    
    func testSelectedCategory() {
        let mockCategories = [CategoryModel(id: 1, name: "test")]
        interactor.categories = mockCategories
        
        var deselectIndex: Int?
        let deselectMock: (Int?) -> Void = { index in
            deselectIndex = index
        }
        
        interactor.selectedCategory(index: 0, deselectRow: deselectMock)
        
        XCTAssertEqual(deselectIndex, 0)
        XCTAssertEqual(completionMock.selectedCategoryId, 1)
        XCTAssertEqual(completionMock.selectedCategoryName, "test")
        XCTAssertTrue(presenterMock.dismissViewControllerCalled)
    }
}

// MARK: - Mocks
final class CategoryPresenterMock: CategoryPresentationLogic {
    var presentStartCalled = false
    var dismissViewControllerCalled = false
    
    func presentStart() {
        presentStartCalled = true
    }
}

extension CategoryPresenterMock: CategoryRouterLogic {
    func dismissViewController() {
        dismissViewControllerCalled = true
    }
}

final class CategoryServiceMock: CategoryWorker {
    var fetchCategoryResult: Result<CategoriesResponse?, Error>?
    
    func fetchCategory(completion: ((Result<CategoriesResponse?, Error>) -> Void)?) {
        if let result = fetchCategoryResult {
            completion?(result)
        }
    }
}

final class CategoryCompletionMock {
    var selectedCategoryId: Int?
    var selectedCategoryName: String?

    func completion(id: Int, name: String) {
        selectedCategoryId = id
        selectedCategoryName = name
    }
}
