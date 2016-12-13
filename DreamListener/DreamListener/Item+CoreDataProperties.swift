//
//  Item+CoreDataProperties.swift
//  DreamListener
//
//  Created by Ebubekir on 12/5/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var createdDate: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var toImagefromItem: Image?
    @NSManaged public var toItemTypefromItem: ItemType?
    @NSManaged public var toStorefromItem: Store?

}
