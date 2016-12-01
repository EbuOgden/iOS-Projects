//
//  PartyCell.swift
//  PartyRock
//
//  Created by Ebubekir on 11/30/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

class PartyCell: UITableViewCell {

    @IBOutlet weak var videoThumbnail: UIImageView!
    
    @IBOutlet weak var videoTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func updateUI(partyRock: PartyRock){
        self.videoTitle.text = partyRock.getVideoTitle
        
        let url = URL(string: partyRock.getImageURL)
        
        DispatchQueue.global().async { // background thread can not affect UI we must use sync to change UI
            
            do {
                let data = try Data(contentsOf: url!) // Download Data from given URL
                DispatchQueue.global().sync {
                    self.videoThumbnail.image = UIImage(data: data)
                }
            } catch {
                print("Image Download Error")
            }
            
        }
    }
}
