//
//  MainVC.swift
//  DreamListener
//
//  Created by Ebubekir on 12/4/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    // NSF Works with Core data with your table view to easy work with fetch data
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var fetchedResultsController : NSFetchedResultsController<Item>! // We will control Item Type Data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        
        //createTestData()
        
        initialTypeData()
        initialStoreData()
        
        attemptFetch()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // -> Fill cells to tableView
        
        if let cell = itemsTableView.dequeueReusableCell(withIdentifier: "itemIdentifier", for: indexPath) as? ItemCell {
            
            configureCellPassData(cell: cell, indexPath: indexPath as NSIndexPath) // -> For every cell we are callng this function and passing every cell item with index
            
            return cell
            
        }
        
        return UITableViewCell()

    }
    
    func configureCellPassData(cell: ItemCell, indexPath: NSIndexPath){
        let localItem = fetchedResultsController.object(at: indexPath as IndexPath) // -> Creating new object for Item
        
        cell.configureCell(item: localItem) // -> Calling ItemCell's configureCell function with passing new created object
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // -> If user clicked Cell
        
        if let objects = fetchedResultsController.fetchedObjects , objects.count > 0 {
            
            let item = objects[indexPath.row]
            
            print(item)
            performSegue(withIdentifier: "showItemDetail", sender: item as Item)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemDetail" {
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let localSections = fetchedResultsController.sections { // -> If can took CoreData sections
            
            let sectionInfo = localSections[section] // -> assign as an array to sectionInfo
            
            return sectionInfo.numberOfObjects // -> return number of CoreData objects, how many records you have in the Item CoreData
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { // -> We are getting core data from attemptFetch() function and this function knows how many Item we have, so we have to say, how many section we will have and return that value.
        
        
        if let localSections = fetchedResultsController.sections {
            print(localSections)
            return localSections.count // -> return count of sections
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150 // -> Every Cell gonna 150 height.
    }

    
    func attemptFetch(){
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest() // -> Get Item CoreData Data and assign to fetchRequest variable.
        
        let dateSort = NSSortDescriptor(key: "createdDate", ascending: false) // -> Sort the fetched data    (Sorted with date attribute)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        let typeSort = NSSortDescriptor(key: "toItemTypefromItem.type", ascending: true)
        
        if segment.selectedSegmentIndex == 0{
            fetchRequest.sortDescriptors = [dateSort] // -> Sorted data will be saved into array, we can use array.count functionality for numberOfRowsInSection
        }
        else if segment.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [priceSort]
        }
        else if segment.selectedSegmentIndex == 2{
            fetchRequest.sortDescriptors = [titleSort]
        }else if segment.selectedSegmentIndex == 3{
            fetchRequest.sortDescriptors = [typeSort]
        }
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil /* nil because, we want to return all results*/, cacheName: nil) // -> Creating NSFetch, will perform fetch functionality of core data.
        
        self.fetchedResultsController = controller // -> Binding general controller with local controller
        
        controller.delegate = self // -> Change methods and insert, delete, update and move events has to know which controller will controlling
        
        do { // -> Fetch can be fail, we covered up with Catcher. In addition -> performFetch function has throw so we have to use Catcher.
            
            try controller.performFetch() // -> Fetch all data
        } catch {
            
            let err = error as NSError
            print("\(err)")
        }
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        attemptFetch() // -> Sorted Items
        itemsTableView.reloadData() // -> Reload with sorted items
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { // -> If our data has changed, this function will be triggered and will do updates to itemsTableView.
        itemsTableView.beginUpdates()
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { // -> Data changes finished
        itemsTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) { // -> We can catch Insert, Delete, Update and Moved events in CoreData with this function
        
        switch(type){
        case.insert: // -> Insert case, add new row to the itemsTable
            if let indexPath = newIndexPath {
                itemsTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete: // -> Delete case, delete that row from the itemsTable
            if let indexPath = indexPath {
                itemsTableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update: // -> Update case, update the selected row
            if let indexPath = indexPath {
                let cell = itemsTableView.cellForRow(at: indexPath) as! ItemCell // -> Get selected row and cast to ItemCell type
                configureCellPassData(cell: cell, indexPath: indexPath as NSIndexPath)
                // Do update process
            }
            break
        case.move: // -> Drag and Drop functionality, reorder the table
            if let indexPath = indexPath {
                itemsTableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                itemsTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        
        }
        
    }
    
    func initialStoreData(){
        let store = Store(context: context)
        store.name = "Kentucky"
        
        let store2 = Store(context: context)
        store2.name = "Best Buy"
        
        let store3 = Store(context: context)
        store3.name = "Amazon"
        
        let store4 = Store(context: context)
        store4.name = "Walmart"
        
        let store5 = Store(context: context)
        store5.name = "CVA"
        
        delegate.saveContext()
        
    }
    
    func initialTypeData(){
        let type = ItemType(context: context)
        type.type = "Electronic"
        
        let type1 = ItemType(context: context)
        type1.type = "Car"
        
        let type2 = ItemType(context: context)
        type2.type = "House Kit"
        
        let type3 = ItemType(context: context)
        type3.type = "Accessorize"
        
        let type4 = ItemType(context: context)
        type4.type = "Clothes"
        
        delegate.saveContext()
    }

    
    func createTestData(){
        let item = Item(context: context)
        
        item.title = "MacBook Pro"
        item.price = 1500
        item.details = "New MacBook Pro will blow up your minds, be carefull when you are using it!"
        
        let item2 = Item(context: context)
        
        item2.title = "Beats"
        item2.price = 350
        item2.details = "This is the future. Ladies and gentelman, this is the most noisless headphone in the world"
        
        let item3 = Item(context: context)
        
        item3.title = "Tesla Model S"
        item3.price = 150000
        item3.details = "Eh"
        
        delegate.saveContext()
    }
}


















