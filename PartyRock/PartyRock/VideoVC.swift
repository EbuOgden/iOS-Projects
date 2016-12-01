//
//  VIdeoVC.swift
//  PartyRock
//
//  Created by Ebubekir on 11/30/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

class VideoVC: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var songTitle: UILabel!
    
    private var partyRockObj : PartyRock!
    
    public var partyRock : PartyRock! {
        get {
            return partyRockObj
        }
        set {
            partyRockObj = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        songTitle.text = partyRock.getVideoTitle
        
        webView.loadHTMLString(partyRock.getVideoURL, baseURL: nil)
        
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
