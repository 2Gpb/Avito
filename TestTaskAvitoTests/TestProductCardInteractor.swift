//
//  TestProductCardInteractor.swift
//  TestTaskAvitoTests
//
//  Created by Peter on 16.02.2025.
//

import XCTest
@testable import TestTaskAvito

final class TestProductCardInteractor: XCTestCase {
    private var interactor: ProductCardInteractor!
    private var presenterMock: ProductCardPresenterMock!
    private var serviceMock: ProductCoreDataServiceMock!
    private var productModel: ProductCardModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        presenterMock = ProductCardPresenterMock()
        serviceMock = ProductCoreDataServiceMock()
        productModel = ProductCardModel(
            id: 1,
            imageAddress: "https://www.google.com",
            price: "$30",
            title: "Product",
            description: "Description",
            category: "Shoes"
        )
        
        interactor = ProductCardInteractor(
            presenter: presenterMock,
            model: productModel,
            service: serviceMock
        )
    }

    override func tearDownWithError() throws {
        interactor = nil
        presenterMock = nil
        serviceMock = nil
        productModel = nil
        try super.tearDownWithError()
    }
    
    func testLoadStart() {
        serviceMock.number = 5
        interactor.loadStart()
        
        XCTAssertTrue(presenterMock.presentStartCalled)
        XCTAssertEqual(presenterMock.presentedModel?.id, productModel.id)
        XCTAssertEqual(presenterMock.presentedNumber, 5)
        XCTAssertEqual(serviceMock.presentedId, 1)
    }
    
    func testAddFirstNumber() {
        serviceMock.number = 5
        
        interactor.addFirstNumber()
        
        XCTAssertTrue(serviceMock.addCalled)
        XCTAssertTrue(presenterMock.presentNumberCalled)
        XCTAssertEqual(presenterMock.presentedNumber, 5)
    }
    
    func testIncreaseNumber() {
        serviceMock.number = 5
        interactor.increaseNumber()
        
        XCTAssertTrue(serviceMock.increaseNumberCalled)
        XCTAssertTrue(presenterMock.presentNumberCalled)
        XCTAssertEqual(presenterMock.presentedNumber, 5)
        XCTAssertEqual(serviceMock.presentedId, 1)
    }
    
    func testDecreaseNumber() {
        serviceMock.number = 5
        interactor.decreaseNumber()
        
        XCTAssertTrue(serviceMock.decreaseNumberCalled)
        XCTAssertTrue(presenterMock.presentNumberCalled)
        XCTAssertEqual(presenterMock.presentedNumber, 5)
        XCTAssertEqual(serviceMock.presentedId, 1)
    }
    
    func testGoBack() {
        interactor.goBack()
        
        XCTAssertTrue(presenterMock.popViewControllerCalled)
    }
    
    func testShareProduct() {
        let shareSheet = UIActivityViewController(
            activityItems: [],
            applicationActivities: nil
        )
        
        interactor.shareProduct(shareSheet: shareSheet)
        
        XCTAssertTrue(presenterMock.presentShareSheetCalled)
        XCTAssertEqual(presenterMock.sharedSheet, shareSheet)
    }
}

// MARK: - Mocks
final class ProductCardPresenterMock: ProductCardPresentationLogic {
    var presentedModel: ProductCardModel?
    var presentedNumber: Int?
    var sharedSheet: UIActivityViewController?
    
    var presentStartCalled = false
    var presentNumberCalled = false
    var popViewControllerCalled = false
    var presentShareSheetCalled = false
    
    func presentStart(with model: ProductCardModel, number: Int) {
        presentStartCalled = true
        presentedModel = model
        presentedNumber = number
    }
    
    func present(number: Int) {
        presentNumberCalled = true
        presentedNumber = number
    }
    
    func present(shareSheet: UIActivityViewController) {
        presentShareSheetCalled = true
        sharedSheet = shareSheet
    }
}

extension ProductCardPresenterMock: ProductCardRouterLogic {
    func popViewController() {
        popViewControllerCalled = true
    }
}

final class ProductCoreDataServiceMock: CoreDataService, ProductCoreDataServiceLogic {
    var number: Int = 0
    var presentedId: Int = 0
    var addCalled = false
    var increaseNumberCalled = false
    var decreaseNumberCalled = false
    
    override func getNumber(of id: Int) -> Int {
        presentedId = id
        return number
    }
    
    func add(element: ProductCardModel) {
        addCalled = true
    }
    
    override func increaseNumber(of id: Int) {
        presentedId = id
        increaseNumberCalled = true
    }
    
    override func decreaseNumber(of id: Int) {
        presentedId = id
        decreaseNumberCalled = true
    }
}
