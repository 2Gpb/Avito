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
    
    func getNumber(of id: Int) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do {
            guard let products = try context.fetch(fetchRequest) as? [Product] else { return 0 }
            return Int(products.first(where: { $0.id == Int16(id) })?.number ?? 0)
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
}
