//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Damian Pelovski on 1/13/17.
//  Copyright © 2017 Damian Pelovski. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var outputLbl: UILabel!
    
    @IBOutlet weak var stackHex: UIStackView!
    var btnSound: AVAudioPlayer!
    
    // currentOperation starts with empty
    var currentOperation = Operation.Empty
    
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    //Enum for the different kinds of operations
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //path is the path to the resource btn.wav
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        // iOS works with URL's so we create a URL from a string path
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            //AVAudioPlayer is a player created from a URL
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            //preparing the btnSound to play
            btnSound.prepareToPlay()
        }
        catch let err as NSError {
            //if any error occurs we would print it to the console so we can see the error message
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
        
        typeLabel.text = "DEC"
    }

    // IBAction linked to the 9 numbers
    @IBAction func numberPressed(sender: UIButton) {
        //when a number is pressed from 1-9 we play a sound
            playSound()
        //we use sender.tag, because we used the tag attribute for every button from 1 ot 9 in the storyboard. We then append the content of the tag to the runningNumber
        runningNumber += "\(sender.tag)"
        
        //we append the running number to the label that we are using
        outputLbl.text = runningNumber
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        outputLbl.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide, inSystem: typeLabel.text!)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply, inSystem: typeLabel.text!)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract, inSystem: typeLabel.text!)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        processOperation(operation: .Add, inSystem: typeLabel.text!)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        processOperation(operation: currentOperation, inSystem: typeLabel.text!)
    }
    
    
    
    func playSound() {
        //stop the button from playing the sound if it is currently playing it
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation, inSystem: String) {
        playSound()
        
        switch inSystem {
        case "BIN":
            calculateBin(operation: operation)
            break
        case "OCT":
            calculateOct(operation: operation)
            break
        case "DEC":
            calculateDecimal(operation: operation)
            break
        case "HEX":
            calculateHex(operation: operation)
            break
        default:
            break
        }
        
        
    }
    
    func calculateOct(operation: Operation) {
        if currentOperation != Operation.Empty {
            
            //The user selected an operator,but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                let leftSideVal = Int(leftValStr, radix: 8)!
                let rightSideVal = Int(leftValStr, radix: 8)!
                print(leftSideVal)
                print(rightSideVal)
                
                if currentOperation == Operation.Multiply {
                    result = "\(leftSideVal * rightSideVal)"
                } else if currentOperation == Operation.Divide {
                    result = "\(leftSideVal / rightSideVal)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(leftSideVal - rightSideVal)"
                } else if currentOperation == Operation.Add {
                    result = "\(leftSideVal + rightSideVal)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            
            currentOperation = operation
        }

    }
    
    func calculateHex(operation: Operation) {
        if currentOperation != Operation.Empty {
            
            //The user selected an operator,but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                let leftSideVal = Int(leftValStr, radix: 16)!
                let rightSideVal = Int(leftValStr, radix: 16)!
                print(leftSideVal)
                print(rightSideVal)
                
                if currentOperation == Operation.Multiply {
                    result = "\(leftSideVal * rightSideVal)"
                } else if currentOperation == Operation.Divide {
                    result = "\(leftSideVal / rightSideVal)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(leftSideVal - rightSideVal)"
                } else if currentOperation == Operation.Add {
                    result = "\(leftSideVal + rightSideVal)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            
            currentOperation = operation
        }
        
    }
    
    func calculateBin(operation: Operation) {
        if currentOperation != Operation.Empty {
            
            //The user selected an operator,but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                let leftSideVal = Int(leftValStr, radix: 2)!
                let rightSideVal = Int(leftValStr, radix: 2)!
                print(leftSideVal)
                print(rightSideVal)
                
                if currentOperation == Operation.Multiply {
                    result = "\(leftSideVal * rightSideVal)"
                } else if currentOperation == Operation.Divide {
                    result = "\(leftSideVal / rightSideVal)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(leftSideVal - rightSideVal)"
                } else if currentOperation == Operation.Add {
                    result = "\(leftSideVal + rightSideVal)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            
            currentOperation = operation
        }

    }
    
    func calculateDecimal(operation: Operation) {
        if currentOperation != Operation.Empty {
            
            //The user selected an operator,but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            
            currentOperation = operation
        }
    }
    
    func restartAfterChoosingType() {
        outputLbl.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
    }
    
    
    @IBAction func binPressed(_ sender: Any) {
        playSound()
        typeLabel.text = "BIN"
        restartAfterChoosingType()
        stackHex.isHidden = true

    }
    
    @IBAction func hexPressed(_ sender: Any) {
        playSound()
        typeLabel.text = "HEX"
        restartAfterChoosingType()
        stackHex.isHidden = false
    }
    @IBAction func decPressed(_ sender: Any) {
        playSound()
        typeLabel.text = "DEC"
        restartAfterChoosingType()
        stackHex.isHidden = true

    }
    @IBAction func octPressed(_ sender: Any) {
        playSound()
        typeLabel.text = "OCT"
        restartAfterChoosingType()
        stackHex.isHidden = true

    }
    
    @IBAction func transform(_ sender: Any) {
        
        switch typeLabel.text! {
        case "BIN":
            outputLbl.text! = String(Int(result)!, radix: 2)
        case "OCT":
            outputLbl.text! = String(Int(result)!, radix: 8)
        case "HEX":
            outputLbl.text! = String(Int(result)!, radix: 16)
        default:
            break
        }
        
        
    }
    
}

