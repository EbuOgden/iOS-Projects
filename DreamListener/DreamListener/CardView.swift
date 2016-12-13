//
//  CardView.swift
//  DreamListener
//
//  Created by Ebubekir on 12/5/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

private var isMaterial = false

extension UIView { // Extension Means; In project, you can select this property in every UIView Element
    
    @IBInspectable var materialDesign: Bool { // You can add new features to your view by @IBInspectable
        get {
            return isMaterial
        }

        set {
            isMaterial = newValue
            
            if isMaterial {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 5.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 5.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            }
            else{
                self.layer.cornerRadius = 0.0
                self.layer.shadowOpacity = 0.0
                self.layer.shadowRadius = 0.0
                self.layer.masksToBounds = true
                self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                self.layer.shadowColor = nil
            }
        }
    }
}
