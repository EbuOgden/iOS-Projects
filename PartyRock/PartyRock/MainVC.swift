//
//  ViewController.swift
//  PartyRock
//
//  Created by Ebubekir on 11/29/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    var partyRockArray = [PartyRock]() // We will fill this array with elements of PartyRock class's objects
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let p1 = PartyRock(imageURL: "https://yt3.ggpht.com/-LEydX3sr14I/AAAAAAAAAAI/AAAAAAAAAAA/QuP-jdZZWkU/s100-c-k-no-mo-rj-c0xffffff/photo.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/KQ6zr6kCPj8\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Party Rock Anthem")
        
        let p2 = PartyRock(imageURL: "http://www.mtv.com/crop-images/2013/09/10/lmfao.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/watch?v=SkTt9k4Y-a8\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Sorry for Party Rocking")
        
        let p3 = PartyRock(imageURL: "http://www.latestsongsnews.com/wp-content/uploads/2012/08/lmfao-party-rock-anthem-song.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/watch?v=zIh5AHxh-Ok\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "ASDJOASD")
        
        let p4 = PartyRock(imageURL: "http://cps-static.rovicorp.com/3/JPG_500/MI0003/180/MI0003180026.jpg?partner=allrovi.com", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/watch?v=J4tpVq8Xk-g\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Redfoo Finds a New Love")
        
        let p5 = PartyRock(imageURL: "https://yt3.ggpht.com/-LEydX3sr14I/AAAAAAAAAAI/AAAAAAAAAAA/QuP-jdZZWkU/s100-c-k-no-mo-rj-c0xffffff/photo.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/watch?v=xGiBiHocSZM\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Redfoo - New Thang")
        
        partyRockArray.append(p1)
        partyRockArray.append(p2)
        partyRockArray.append(p3)
        partyRockArray.append(p4)
        partyRockArray.append(p5)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Add Row to specific position, can use for socket.io!
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as? PartyCell { // If TableView don't have any cell this method automaticly create new one by using PartyCell codes and casting
            
            // identifier setted in Main.storyboard
            
            // We can access PartyCell functions because we gave it class in Main.storyboard as a cell class
            
            let partyRock = partyRockArray[indexPath.row]
            
            cell.updateUI(partyRock: partyRock)
        
            return cell
        }
        else {
            return UITableViewCell() // If can not create any cell to table, return an empty one
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyRockArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // When user clicked the row
        
        let partyRock = partyRockArray[indexPath.row] // Select row and get datas
        
        performSegue(withIdentifier: "videoVC", sender: partyRock)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? VideoVC {
            if let partyRock = sender as? PartyRock!{
                
                destination.partyRock = partyRock
            }
        }
    }
    
}

