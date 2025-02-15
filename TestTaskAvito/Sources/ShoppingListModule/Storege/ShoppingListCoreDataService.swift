//
//  ShoppingListCoreDataService.swift
//  TestTaskAvito
//
//  Created by Peter on 14.02.2025.
//

import UIKit
import CoreData

final class ShoppingListCoreDataService: CoreDataService, ShoppingListCoreDataServiceLogic {
    // MARK: - Properties
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: CRUD
    func getAllProducts() -> [Product] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do {
            guard let products = try context.fetch(fetchRequest) as? [Product] else { return [] }
            return products
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func deleteAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do {
            guard let products = try context.fetch(fetchRequest) as? [Product] else { return }
            products.forEach({ product in
                context.delete(product)
            })
        } catch {
            print(error.localizedDescription)
        }
        
        appDelegate.saveContext()
    }
}
