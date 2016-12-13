//
//  Image+CoreDataProperties.swift
//  DreamListener
//
//  Created by Ebubekir on 12/5/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItemfromImage: Item?
    @NSManaged public var toStorefromImage: NSSet?

}

// MARK: Generated accessors for toStorefromImage
extension Image {

    @objc(addToStorefromImageObject:)
    @NSManaged public func addToToStorefromImage(_ value: Store)

    @objc(removeToStorefromImageObject:)
    @NSManaged public func removeFromToStorefromImage(_ value: Store)

    @objc(addToStorefromImage:)
    @NSManaged public func addToToStorefromImage(_ values: NSSet)

    @objc(removeToStorefromImage:)
    @NSManaged public func removeFromToStorefromImage(_ values: NSSet)

}
