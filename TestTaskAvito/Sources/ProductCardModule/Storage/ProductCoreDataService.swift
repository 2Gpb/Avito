//
//  ProductCoreDataService.swift
//  TestTaskAvito
//
//  Created by Peter on 14.02.2025.
//

import UIKit
import CoreData

final class ProductCoreDataService: CoreDataService, ProductCoreDataServiceLogic {
    // MARK: - Properties
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    func add(element: ProductModel.Element) {
        guard let entityDescription = NSEntityDescription.entity(
            forEntityName: "Product",
            in: context
        ) else { return }
        
        let product = Product(entity: entityDescription, insertInto: context)
        product.number = 1
        product.id = Int16(element.id)
        product.title = element.title
        product.price = "\(element.price)$"
        product.desc = element.description
        product.category = element.category.name
        product.imageAddress = element.images[0]
        
        appDelegate.saveContext()
    }
}
