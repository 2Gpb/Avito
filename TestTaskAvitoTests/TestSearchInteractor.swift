//
//  TestSearchInteractor.swift
//  TestTaskAvitoTests
//
//  Created by Peter on 16.02.2025.
//

import XCTest
@testable import TestTaskAvito

final class TestSearchInteractor: XCTestCase {
    private var interactor: SearchInteractor!
    private var mockPresenter: MockSearchPresenter!
    private var mockProductsService: MockProductsService!
    private var mockStorageService: MockUserDefaultsService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockPresenter = MockSearchPresenter()
        mockProductsService = MockProductsService()
        mockStorageService = MockUserDefaultsService()
        
        interactor = SearchInteractor(
            presenter: mockPresenter,
            service: mockProductsService,
            storage: mockStorageService
        )
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockProductsService = nil
        mockStorageService = nil
        super.tearDown()
    }
    
    func testLoadStart() {
        interactor.loadStart()
        XCTAssertTrue(mockProductsService.fetchProductsCalled)
    }

    func testLoadProductCard() {
        interactor.products = [
            ProductModel.Element(
                id: 1,
                title: "Test",
                price: 100,
                description: "Desc",
                images: [""],
                creationAt: "2025",
                updatedAt: "2026",
                category: ProductModel.Category(id: 1, name: "TestCategory", image: "")
            )
        ]
        
        interactor.loadProductCard(for: 0)
        
        XCTAssertTrue(mockPresenter.routeToProductCardCalled)
        XCTAssertEqual(mockPresenter.routedProduct?.title, "Test")
    }

    func testLoadSearch() {
        interactor.loadSearch(with: "newQuery")

        let history: [String] = mockStorageService.get(
            forKey: UserDefaultsKeys.history.rawValue,
            defaultValue: []
        )
        
        XCTAssertEqual(history.first, "newQuery")
        XCTAssertTrue(mockProductsService.fetchProductsCalled)
    }

    func testLoadSelectedQuery() {
        mockStorageService.set(
            value: ["query1", "query2"],
            forKey: UserDefaultsKeys.history.rawValue
        )

        interactor.loadSelectedQuery(with: 1)

        XCTAssertEqual(interactor.filters.title, "query2")
        XCTAssertTrue(mockProductsService.fetchProductsCalled)
    }

    func testLoadSelectCategory() {
        interactor.loadSelectCategory()

        XCTAssertEqual(interactor.filters.categoryId, 1)
        XCTAssertEqual(interactor.filters.categoryName, "MockCategory")
        XCTAssertTrue(mockPresenter.presentFiltersCalled)
    }

    func testLoadPriceSelector() {
        interactor.loadPriceSelector()

        XCTAssertEqual(interactor.filters.priceFrom, 100)
        XCTAssertEqual(interactor.filters.priceTo, 500)
        XCTAssertTrue(mockPresenter.presentFiltersCalled)
    }

    func testLoadProductsSuccess() {
        mockProductsService.mockResponse = [
            ProductModel.Element(
                id: 1,
                title: "Test",
                price: 100,
                description: "Desc",
                images: [""],
                creationAt: "2025",
                updatedAt: "2026",
                category: ProductModel.Category(id: 1, name: "TestCategory", image: "")
            )
        ]

        interactor.loadStart()

        XCTAssertEqual(interactor.products.count, 1)
        XCTAssertTrue(mockPresenter.presentStartCalled)
    }

    func testLoadProductsError() {
        mockProductsService.shouldReturnError = true

        interactor.loadStart()

        XCTAssertTrue(mockPresenter.presentStartCalled)
    }
}

// MARK: - Mocks
final class MockSearchPresenter: SearchPresentationLogic {
    var presentStartCalled = false
    var presentFiltersCalled = false
    var routeToProductCardCalled = false
    var routedProduct: ProductModel.Element?
    
    func presentStart(with title: String?, errorState: Bool, emptyState: Bool) {
        presentStartCalled = true
    }

    func presentFilters() {
        presentFiltersCalled = true
    }
}

extension MockSearchPresenter: SearchRouterLogic {
    func routeToSelectCategory(
        completion: @escaping (Int, String) -> Void,
        currentCategoryId: Int?
    ) {
        completion(1, "MockCategory")
    }

    func routeToPriceSelector(
        completion: @escaping (Int?, Int?) -> Void,
        currentMin: Int?,
        currentMax: Int?
    ) {
        completion(100, 500)
    }

    func routeToProductCard(with model: ProductModel.Element) {
        routeToProductCardCalled = true
        routedProduct = model
    }
}

final class MockProductsService: ProductsWorker {
    var shouldReturnError = false
    var fetchProductsCalled = false
    var mockResponse: ProductsResponse = []
    
    func fetchProducts(
        for address: ProductModel.Address,
        completion: ((Result<ProductsResponse?, Error>) -> Void)?
    ) {
        fetchProductsCalled = true
        if shouldReturnError {
            completion?(.failure(NSError(domain: "TestError", code: 0)))
        } else {
            completion?(.success(mockResponse))
        }
    }
}

final class MockUserDefaultsService: UserDefaultsLogic {
    private var storage: [String: Any] = [:]

    func set<T>(value: T, forKey key: String) {
        storage[key] = value
    }

    func get<T>(forKey key: String, defaultValue: T) -> T {
        return storage[key] as? T ?? defaultValue
    }

    func removeObject(for key: String) {
        storage.removeValue(forKey: key)
    }
}
