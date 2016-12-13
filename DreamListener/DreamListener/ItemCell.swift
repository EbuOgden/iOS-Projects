//
//  ItemCell.swift
//  DreamListener
//
//  Created by Ebubekir on 12/5/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
    @IBOutlet weak var itemType: UILabel!
    
    @IBOutlet weak var itemStore: UILabel!
    
    public func configureCell(item: Item){
        itemTitle.text = item.title
        itemPrice.text = "$\(item.price)"
        itemDescription.text = item.details
        
        itemType.text = item.toItemTypefromItem?.type
    
        itemStore.text = item.toStorefromItem?.name
        
        thumbnailImage.image = item.toImagefromItem?.image as? UIImage
    }
   
}
