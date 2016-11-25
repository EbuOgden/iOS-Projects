//
//  MusicListVC.swift
//  SwapScreens
//
//  Created by Ebubekir on 11/24/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

class MusicListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func route3rdView(_ sender: Any) {
        let songInformations : [String: String] = ["SongTitle" : "Death Note", "SongDate" : "11/12/13", "Price" : "50"]
        performSegue(withIdentifier: "playSongVC", sender: songInformations)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? PlaySongVC { // Routing to PlaySongVC
            
            if let song = sender as? Dictionary<String, String> {
                destination.getSongInformations = song
            }
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
