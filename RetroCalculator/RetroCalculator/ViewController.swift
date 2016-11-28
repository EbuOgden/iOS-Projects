//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Ebubekir on 11/24/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var btnPress : AVAudioPlayer!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    enum OperationType : String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Result = "Result"
    }
    
    var runningNumber = ""
    
    var currentOperation = OperationType.Empty
    
    var firstNumberStr = ""
    
    var secondNumberStr = ""
    
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let musicPath = Bundle.main.path(forResource: "btn", ofType: "wav") // Get File Path
        
        let musicURL = URL(fileURLWithPath: musicPath!) // Convert to URL
        
        do {
            try btnPress = AVAudioPlayer(contentsOf: musicURL)
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
            
    
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playMusic()
        
        runningNumber += "\(sender.tag)"
        
        outputLabel.text = runningNumber
        
    }
    
    func playMusic(){
        if(btnPress.isPlaying){
            btnPress.stop()
        }
        
        btnPress.play()
    }
    
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        
        currentOperation = OperationType.Empty
        firstNumberStr = ""
        secondNumberStr = ""
        runningNumber = "0.0"
        outputLabel.text = runningNumber
        
    }
    @IBAction func operationButtonPressed(sender: UIButton){
        
        playMusic()
        
        switch sender.tag {
        case 0:
            calculateResult(operation: .Divide)
            break
        case 1:
            calculateResult(operation: .Multiply)
            break
        case 2:
            calculateResult(operation: .Subtract)
            break
        case 3:
            calculateResult(operation: .Add)
            break
        case 5:
            calculateResult(operation: .Result)
            break
        default:
            print("Unfamilier Button")
            break
        }
    }
    
    func calculateResult(operation : OperationType){
        
        if currentOperation != OperationType.Empty { // User Selected Operation
            
            if runningNumber != "" {
                
                secondNumberStr = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case OperationType.Divide:
                    result = "\(Double(firstNumberStr)! / Double(secondNumberStr)!)"
                    secondNumberStr = ""
                    break
                case OperationType.Multiply:
                    result = "\(Double(firstNumberStr)! * Double(secondNumberStr)!)"
                    secondNumberStr = ""
                    break
                case OperationType.Subtract:
                    result = "\(Double(firstNumberStr)! - Double(secondNumberStr)!)"
                    secondNumberStr = ""
                    break
                case OperationType.Add:
                    result = "\(Double(firstNumberStr)! + Double(secondNumberStr)!)"
                    secondNumberStr = ""
                    break
                default:
                    break
                }
                
                firstNumberStr = result // Operation should be continuous so we assigned the result value to the firstNumberStr
                outputLabel.text = result
                
            }
            
            currentOperation = operation

        }
        else {
            firstNumberStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            outputLabel.text = runningNumber
        }
    }
    
}

