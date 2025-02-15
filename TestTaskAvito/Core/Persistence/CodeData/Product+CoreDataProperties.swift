//
//  Product+CoreDataProperties.swift
//  TestTaskAvito
//
//  Created by Peter on 14.02.2025.
//
//

import Foundation
import CoreData


extension Product {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var imageAddress: String?
    @NSManaged public var title: String?
    @NSManaged public var price: String?
    @NSManaged public var desc: String?
    @NSManaged public var category: String?
    @NSManaged public var number: Int16
    @NSManaged public var id: Int16
}

extension Product : Identifiable { }
