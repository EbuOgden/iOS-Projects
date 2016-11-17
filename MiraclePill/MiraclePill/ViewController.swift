//
//  ViewController.swift
//  MiraclePill
//
//  Created by Ebubekir on 11/16/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pillPhoto: UIImageView!

    @IBOutlet weak var miraclePillsLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var divider: UIView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var streetAddressLabel: UILabel!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var statePickerButton: UIButton!
    
    @IBOutlet weak var statePicker: UIPickerView!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var zipcodeLabel: UILabel!
    
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    @IBOutlet weak var successPhoto: UIImageView!
    
    
    let stateArray = ["", "California", "Alaska", "Alabama", "Seattle", "New York"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statePicker.dataSource = self
        statePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stateButtonClicked(_ sender: Any) {
        statePicker.isHidden = false
        countryLabel.isHidden = true
        countryTextField.isHidden = true
        zipcodeLabel.isHidden = true
        zipcodeTextField.isHidden = true
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statePicker.isHidden = true
        countryLabel.isHidden = false
        countryTextField.isHidden = false
        zipcodeLabel.isHidden = false
        zipcodeTextField.isHidden = false
        statePickerButton.setTitle(stateArray[row], for: UIControlState.normal)
        
    }

    @IBAction func buynowButtonClick(_ sender: Any) {
        pillPhoto.isHidden = true
        miraclePillsLabel.isHidden = true
        priceLabel.isHidden = true
        divider.isHidden = true
        fullNameLabel.isHidden = true
        fullNameTextField.isHidden = true
        streetAddressLabel.isHidden = true
        addressTextField.isHidden = true
        cityLabel.isHidden = true
        cityTextField.isHidden = true
        stateLabel.isHidden = true
        statePickerButton.isHidden = true
        statePicker.isHidden = true
        countryLabel.isHidden = true
        countryTextField.isHidden = true
        zipcodeLabel.isHidden = true
        zipcodeTextField.isHidden = true
        successPhoto.isHidden = false
        
    }
    
}

