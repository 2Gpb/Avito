//
//  TestShoppingListInteractor.swift
//  TestTaskAvitoTests
//
//  Created by Peter on 16.02.2025.
//

import XCTest
@testable import TestTaskAvito

final class TestShoppingListInteractor: XCTestCase {
    var interactor: ShoppingListInteractor!
    var mockPresenter: ShoppingListPresenterMock!
    var mockService: ShoppingListServiceMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockPresenter = ShoppingListPresenterMock()
        mockService = ShoppingListServiceMock()
        interactor = ShoppingListInteractor(presenter: mockPresenter, service: mockService)
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockService = nil
        super.tearDown()
    }

    func testLoadStart() {
        let product = Product(
            id: 1,
            imageAddress: "image.png",
            title: "Apple",
            price: "10$",
            number: 2,
            category: "Fruit",
            desc: "Red Apple"
        )
        
        mockService.products = [product]
        interactor.loadStart()

        XCTAssertEqual(interactor.products.count, 1)
        XCTAssertEqual(mockPresenter.presentedEmptyState, false)
    }

    func testClearCart() {
        interactor.products = [
            ShoppingListItemModel(
                id: 1,
                image: "",
                name: "Apple",
                price: "10",
                count: 2,
                category: "Fruit",
                description: "Red apple"
            )
        ]

        interactor.clearCart()

        XCTAssertTrue(interactor.products.isEmpty)
        XCTAssertEqual(mockPresenter.presentedEmptyState, true)
    }

    func testDeleteProduct() {
        let product = Product(
            id: 1,
            imageAddress: "image.png",
            title: "Apple",
            price: "10$",
            number: 2,
            category: "Fruit",
            desc: "Red Apple"
        )
        
        mockService.products = [product]
        interactor.loadStart()
        interactor.deleteProduct(at: 1)

        XCTAssertTrue(interactor.products.isEmpty)
        XCTAssertEqual(mockPresenter.presentedEmptyState, true)
    }

    func testShareCart() {
        interactor.products = [
            ShoppingListItemModel(
                id: 1,
                image: "",
                name: "Apple",
                price: "10",
                count: 2,
                category: "Fruit",
                description: "Red apple"
            ),
            ShoppingListItemModel(
                id: 2,
                image: "",
                name: "Banana",
                price: "5",
                count: 3,
                category: "Fruit",
                description: "Yellow banana"
            )
        ]

        interactor.shareCart()

        XCTAssertEqual(mockPresenter.presentedShareSheetItems, ["Apple", "Banana"])
    }

    func testLoadProductCard() {
        interactor.products = [
            ShoppingListItemModel(
                id: 1,
                image: "",
                name: "Apple",
                price: "10",
                count: 2,
                category: "Fruit",
                description: "Red apple"
            )
        ]

        interactor.loadProductCard(for: 0)

        XCTAssertEqual(mockPresenter.presentedProductCard?.name, "Apple")
    }
}


// MARK: - Mocks
final class ShoppingListPresenterMock: ShoppingListPresentationLogic {
    var presentedEmptyState: Bool?
    var presentedShareSheetItems: [String]?
    var presentedProductCard: ShoppingListItemModel?
    
    func presentProducts(emptyState: Bool) {
        presentedEmptyState = emptyState
    }
    
    func presentShareSheet(_ shareItems: [String]) {
        presentedShareSheetItems = shareItems
    }
    
    func presentAlert(id: Int) { }
}

extension ShoppingListPresenterMock: ShoppingListRouterLogic {
    func presentProductCard(with model: ShoppingListItemModel) {
        presentedProductCard = model
    }
}

final class ShoppingListServiceMock: CoreDataService, ShoppingListCoreDataServiceLogic {
    var products: [Product] = []
    
    func getAllProducts() -> [Product] {
        return products
    }
    
    func deleteAll() {
        products.removeAll()
    }
    
    override func deleteElement(of id: Int) {
        products.removeAll { $0.id == Int16(id) }
    }
}

// MARK: - Extensions
extension Product {
    convenience init(
        id: Int,
        imageAddress: String?,
        title: String?,
        price: String?,
        number: Int,
        category: String?,
        desc: String?
    ) {
        let context = (
            UIApplication.shared.delegate as! AppDelegate
        ).persistentContainer.viewContext
        self.init(context: context)
        self.id = Int16(id)
        self.imageAddress = imageAddress
        self.title = title
        self.price = price
        self.number = Int16(number)
        self.category = category
        self.desc = desc
    }
}
