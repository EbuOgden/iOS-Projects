//
//  Item+CoreDataClass.swift
//  DreamListener
//
//  Created by Ebubekir on 12/5/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() { // Any time insert data to Item object this function will be called.
        super.awakeFromInsert()
        
        self.createdDate = NSDate() // Auto-Date Attribute -> It is same like autoValue function
        
        
    }
}
