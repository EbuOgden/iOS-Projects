//
//  ItemDetailsVC.swift
//  DreamListener
//
//  Created by Ebubekir on 12/7/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var storePickerView: UIPickerView!
    @IBOutlet weak var typePickerView: UIPickerView!
    
    @IBOutlet weak var selectStoreButton: UIButton!
    @IBOutlet weak var selectTypeButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var detailInfoText: UITextView!
    
    @IBOutlet weak var thumbImage: UIButton! // -> We will have been changing image of the button after the image chosen.
    
    var imagePicker : UIImagePickerController! // -> We will use for picker function, when imagePick button clicked, we will have been using this controller for the 1 argument of present function.
    
    var stores = [Store]() // -> Want to select store by UIPickerView, didSelectedRow func returns index of Picker, Had to store Store's data in the array, will can take store name by the index of Picker.
    
    var types = [ItemType]()
    
    public var itemToEdit: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStores()
        getTypes()
        
        storePickerView.delegate = self
        storePickerView.dataSource = self
        
        typePickerView.delegate = self
        typePickerView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if itemToEdit != nil {
            storePickerView.isHidden = false
            selectStoreButton.setTitle("Done", for: .normal)
            loadItemData()
        }
        
    }

    @IBAction func selectStoreClick(_ sender: UIButton) {
        if storePickerView.isHidden {
            storePickerView.isHidden = false
            selectStoreButton.setTitle("Done", for: .normal)
        }
        else {
            
            storePickerView.isHidden = true
            selectStoreButton.setTitle("Select a Store", for: .normal)
        }

    }
    
    @IBAction func selectTypeClick(_ sender: UIButton) {
        
        if typePickerView.isHidden {
            typePickerView.isHidden = false
            selectTypeButton.setTitle("Done", for: .normal)
        }
        else {
            typePickerView.isHidden = true
            selectTypeButton.setTitle("Select a Type", for: .normal)

        }
    }
    @IBAction func selectDoneClick(_ sender: Any) {
        var item: Item!
        
        let image = Image(context: context)
        
        image.image = self.thumbImage.currentBackgroundImage // -> Image's image attribute is Transformable type so we don't need to cast.
        
        if itemToEdit == nil { // -> If creating new Item
            item = Item(context: context)
        }
        else{ // -> If editing exist Item
            item = itemToEdit
        }
        
        if let title = titleTextField.text, let price = priceTextField.text, let detail = detailInfoText.text {
            item.title = title
            item.price = (price as NSString).doubleValue // -> String to Double
            item.details = detail
        }
        
        item.toStorefromItem = self.stores[storePickerView.selectedRow(inComponent: 0)]// -> We have relation between store and item that is why using toStorefromItem which already decleared in CoreData and we will have using self.stores array, because we cannot assign normal String to the Store type variable.
        
        
        item.toItemTypefromItem = self.types[typePickerView.selectedRow(inComponent: 0)]
        
        print("\(item.toItemTypefromItem)")
        
        item.toImagefromItem = image
        
        delegate.saveContext()
        
        _ = navigationController?.popViewController(animated: true) // -> After save, dissmiss the page.
    }
    
    @IBAction func deleteItem(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            delegate.saveContext()
            _ = navigationController?.popViewController(animated: true)
        }
    }
  
    @IBAction func imagePick(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        if pickerView == storePickerView {
            print("STORE PICKER VIEW RULEZ BITCH")
            return stores.count
        }
        else if pickerView == typePickerView {
            print("TYPE PICKER VIEW RULEZ BITCH")
            return types.count
        }
        
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // -> How many columns in the pickerView
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == storePickerView{
            let store = stores[row]
            return store.name
        }
        else if pickerView == typePickerView{
            let type = types[row]
            return type.type
        }
        
        return ""
        
    }
    
    func getStores(){
        let fetchRequest : NSFetchRequest<Store> = Store.fetchRequest()
        
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePickerView.reloadAllComponents() // -> After got Store Core Data, we gotta reload all rows
        } catch {
            let err = error as NSError
            print("Error Occured : \(err)")
            
        }
    }
    
    func getTypes(){
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do{
            self.types = try context.fetch(fetchRequest)
            self.typePickerView.reloadAllComponents()
        }catch {
            let err = error as NSError
            print("Error Occured! : \(err)")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) { // -> If image selected and finished process, change the image select button background image to selected image
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            thumbImage.setBackgroundImage(image, for: .normal)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func loadItemData(){ // -> If user came this page for editing data, we will have filling out our fields with clicked item.
        if let item = itemToEdit {
            titleTextField.text = item.title
            priceTextField.text = "\(item.price)"
            detailInfoText.text = item.details
            
            thumbImage.setBackgroundImage(item.toImagefromItem?.image as? UIImage, for: .normal) // -> For editing image, as we know our Image Core Data's image attribute is transformable so we must to cast our item to UIImage
            
            if let store = item.toStorefromItem { // -> If clicked item had store, we will have replacing PickerView index with the store name one.  
                
                var index = 0
                repeat{
                    let s = stores[index]
                    
                    if s.name == store.name {
                        selectStoreButton.setTitle("Done", for: .normal)
                        storePickerView.isHidden = false
                        storePickerView.selectRow(index, inComponent: 0, animated: true)
                        break
                    }
                    
                    index += 1
                    
                }while (index < self.stores.count)
            }
            
            if let type = item.toItemTypefromItem { // -> Item Type
                var index = 0
                repeat{
                    let t = types[index]
                    
                    if t.type == type.type {
                        selectTypeButton.setTitle("Done", for: .normal)
                        typePickerView.isHidden = false
                        typePickerView.selectRow(index, inComponent: 0, animated: true)
                        break
                    }
                    
                    index += 1
                }while (index < self.types.count)
            }
        }
        
    }
    
}
