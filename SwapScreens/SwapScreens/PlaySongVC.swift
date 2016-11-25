//
//  PlaySongVC.swift
//  SwapScreens
//
//  Created by Ebubekir on 11/24/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

class PlaySongVC: UIViewController {

    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songDateLabel: UILabel!
    @IBOutlet weak var songPriceLabel: UILabel!
    
    
    private var songInformations: [String : String] = [:]
    
    var getSongInformations : Dictionary<String, String> {
        get {
            return songInformations
        }set {
            songInformations = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let songTitle = songInformations["SongTitle"], let songDate = songInformations["SongDate"], let songPrice = songInformations["Price"]{
            
            songNameLabel.text = songTitle
            songDateLabel.text = songDate
            songPriceLabel.text = songPrice
            
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
