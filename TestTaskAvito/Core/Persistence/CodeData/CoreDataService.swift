//
//  CoreDataService.swift
//  TestTaskAvito
//
//  Created by Peter on 14.02.2025.
//

import UIKit
import CoreData

protocol CoreDataServiceLogic {
    func increaseNumber(of id: Int)
    func decreaseNumber(of id: Int)
    func deleteElement(of id: Int)
}

class CoreDataService: CoreDataServiceLogic {
    // MARK: - Properties
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    func increaseNumber(of id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do {
            guard let products = try context.fetch(fetchRequest) as? [Product] else { return }
            let product = products.first(where: { $0.id == Int16(id) })
            product?.number += 1
            
            appDelegate.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func decreaseNumber(of id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do {
            guard let products = try context.fetch(fetchRequest) as? [Product] else { return }
            if let product = products.first(where: { $0.id == Int16(id) }) {
                if product.number > 1 {
                    product.number -= 1
                } else {
                    deleteElement(of: id)
                }
            }
            
            appDelegate.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Private methods
    func deleteElement(of id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do {
            guard let products = try context.fetch(fetchRequest) as? [Product] else { return }
            if let product = products.first(where: { $0.id == Int16(id) }) {
                context.delete(product)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        appDelegate.saveContext()
    }
}
