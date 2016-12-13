//
//  Store+CoreDataProperties.swift
//  DreamListener
//
//  Created by Ebubekir on 12/5/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store");
    }

    @NSManaged public var name: String?
    @NSManaged public var toImagefromStore: NSSet?
    @NSManaged public var toItemfromStore: NSSet?

}

// MARK: Generated accessors for toImagefromStore
extension Store {

    @objc(addToImagefromStoreObject:)
    @NSManaged public func addToToImagefromStore(_ value: Image)

    @objc(removeToImagefromStoreObject:)
    @NSManaged public func removeFromToImagefromStore(_ value: Image)

    @objc(addToImagefromStore:)
    @NSManaged public func addToToImagefromStore(_ values: NSSet)

    @objc(removeToImagefromStore:)
    @NSManaged public func removeFromToImagefromStore(_ values: NSSet)

}

// MARK: Generated accessors for toItemfromStore
extension Store {

    @objc(addToItemfromStoreObject:)
    @NSManaged public func addToToItemfromStore(_ value: Item)

    @objc(removeToItemfromStoreObject:)
    @NSManaged public func removeFromToItemfromStore(_ value: Item)

    @objc(addToItemfromStore:)
    @NSManaged public func addToToItemfromStore(_ values: NSSet)

    @objc(removeToItemfromStore:)
    @NSManaged public func removeFromToItemfromStore(_ values: NSSet)

}
