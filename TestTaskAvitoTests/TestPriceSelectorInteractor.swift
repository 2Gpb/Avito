//
//  TestTaskAvitoTests.swift
//  TestTaskAvitoTests
//
//  Created by Peter on 16.02.2025.
//

import XCTest
@testable import TestTaskAvito

final class TestPriceSelectorInteractor: XCTestCase {
    var interactor: PriceInteractor!
    var presenterMock: PricePresenterMock!
    var receivedMinPrice: Int?
    var receivedMaxPrice: Int?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        presenterMock = PricePresenterMock()
        interactor = PriceInteractor(presenter: presenterMock) { min, max in
            self.receivedMinPrice = min
            self.receivedMaxPrice = max
        }
    }

    override func tearDownWithError() throws {
        presenterMock = nil
        interactor = nil
        receivedMinPrice = nil
        receivedMaxPrice = nil
        try super.tearDownWithError()
    }
    
    func testApplyFilter() {
        let expectedMin = 10
        let expectedMax = 40

        interactor.applyFilter(minPrice: expectedMin, maxPrice: expectedMax)

        XCTAssertEqual(receivedMinPrice, expectedMin)
        XCTAssertEqual(receivedMaxPrice, expectedMax)
        XCTAssertTrue(presenterMock.dismissCalled)
    }
    
    func testCloseScreen() {
        interactor.closeScreen()
        
        XCTAssertTrue(presenterMock.dismissCalled)
    }
}

// MARK: - Mocks
final class PricePresenterMock: PricePresentationLogic {
    var dismissCalled = false
}

extension PricePresenterMock: PriceRouterLogic {
    func dismissViewController() {
        dismissCalled = true
    }
}
