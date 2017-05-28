//
//  ViewController.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 04/05/2017.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, baseDataSentDelegate, destDataSentDelegate {

    //Operation Buttons
    @IBOutlet weak var divideBtn: UIButton!
    @IBOutlet weak var subtractBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    var buttonsEnabled: Bool!
    
    var baseCurrSel: String!
    var destCurrSel: String!
    
    var sortedCurrency:[String] = []
    
    @IBOutlet weak var calculationLbl: UILabel!
    @IBOutlet weak var baseCurrencyBtn: UIButton!
    @IBOutlet weak var baseCurrencyLbl: UILabel!
    
    
    @IBOutlet weak var destinationCurrencyBtn: UIButton!
    @IBOutlet weak var destinationCurrencyLbl: UILabel!
    
    var currentRates: CurrentExchange!
    
    var displayRunningNumber = ""
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    var currentOperation = Operation.Empty
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentRates = CurrentExchange()
    
        currentRates.downloadExchangeRates {}
        
        
        
        self.disableBtns()
        
    }
    
    @IBAction func numberPressed(sender: UIButton){
        
        runningNumber += "\(sender.tag)"
        displayRunningNumber += "\(sender.tag)"
        calculationLbl.text = displayRunningNumber
        baseCurrencyLbl.text = result
        
        print("----------- Number Pressed -------------")
        print("runningNumber = \(runningNumber)")
        print("--------------------------------")
        print("leftValStr = \(leftValStr)")
        print("currentOperation = \(currentOperation)")
        print("rightValStr = \(rightValStr)")
        print("result = \(result)")

        //enables live calculations
//        if rightValStr == "" || leftValStr == "" {
//                result = runningNumber
//        }
//        
//        if result != "" {
//            baseCurrencyLbl.text = result
//        } else {
//            baseCurrencyLbl.text = "0"
//        }
        
        
        //Removes need for Equal Button
//        if currentOperation != Operation.Empty && rightValStr != "" && leftValStr != ""  {
//            rightValStr = runningNumber
//            processOperation(operation: currentOperation)
//        }
        if currentOperation != Operation.Empty {
            liveOperation(operation: currentOperation)
            print("----------- Operaction \(currentOperation) -------------")
        }
        
        
        self.enableBtns()
        
        //Does Converstion
        if self.destCurrSel != nil && self.baseCurrSel != nil && result != "" {
            
            let stringResult = Double(result)!
            let priceToConver = Double(round(stringResult))
            let convertedAmount = Double(self.currentRates.doConvertion(dest: self.destCurrSel, base: self.baseCurrSel, price: priceToConver))!
            
            destinationCurrencyLbl.text = "\(Double(round(convertedAmount)))"
        }
        
    }
    
    func liveOperation(operation:Operation){
        
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                
                rightValStr = runningNumber
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                baseCurrencyLbl.text = result
            }
        }
        
    }
    func processOperation(operation: Operation){
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                baseCurrencyLbl.text = result
                
                //Does Converstion
                if self.destCurrSel != nil && self.baseCurrSel != nil && result != "" {
                    let stringResult = Double(result)!
                    let priceToConver = Double(round(stringResult))
                    
                    let convertedAmount = Double(self.currentRates.doConvertion(dest: self.destCurrSel, base: self.baseCurrSel, price: priceToConver))!
                    
                    destinationCurrencyLbl.text = "\(Double(round(convertedAmount)))"
                }
                
            } else {
                print("rightVal Is empty")
            }
            calculationLbl.text = result
            currentOperation = operation
        }else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        print("-----------Operation Pressed---------------")
        print("runningNumber = \(runningNumber)")
        print("--------------------------------")
        print("leftValStr = \(leftValStr)")
        print("currentOperation = \(currentOperation)")
        print("rightValStr = \(rightValStr)")
        print("result = \(result)")
    }
    @IBAction func clearButton(_ sender: Any) {
        
        runningNumber.removeAll()
        displayRunningNumber.removeAll()
        
        baseCurrencyLbl.text = "0"
        destinationCurrencyLbl.text = "0"
        calculationLbl.text = "0"
        currentOperation = Operation.Empty
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        displayRunningNumber = ""
        result = "0"
        self.disableBtns()
    }
    
    
    
    func userDidEnterBaseData(data: String) {
        self.baseCurrencyBtn.setTitle(data, for: .normal)
        self.baseCurrSel = data
        
    }
    
    func userDidEnterDestData(data: String) {
        self.destinationCurrencyBtn.setTitle(data, for: .normal)
        self.destCurrSel = data
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "baseCurrVCSegue" {
            let baseCurrVC: baseCurrVC = segue.destination as! baseCurrVC
            baseCurrVC.delegate = self
        }
        if segue.identifier == "destCurrVCSegue" {
            let destCurrVC: destCurrVC = segue.destination as! destCurrVC
            destCurrVC.delegate = self
        }
    }
    
    
    @IBAction func baseCurrencyBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "baseCurrVCSegue", sender: self)
    }
    
    @IBAction func destCurrencyBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "destCurrVCSegue", sender: self)
    }
    
    //Operators
    @IBAction func onDividePressed(sender: AnyObject){
        
        if self.buttonsEnabled != false {
            processOperation(operation: .Divide)
            displayRunningNumber += " ÷ "
            
            calculationLbl.text = displayRunningNumber
        }
        self.disableBtns()
        
    }
    @IBAction func onMultiplyPressed(sender: AnyObject){
        if self.buttonsEnabled != false {
            processOperation(operation: .Multiply)
            displayRunningNumber += " X "
//            processOperation(operation: currentOperation)
            calculationLbl.text = displayRunningNumber
        }
        self.disableBtns()
        
    }
    @IBAction func onSubtractPressed(sender: AnyObject){
        if self.buttonsEnabled != false {
            processOperation(operation: .Subtract)
            displayRunningNumber += " - "
//            processOperation(operation: currentOperation)
            calculationLbl.text = displayRunningNumber
        }
        self.disableBtns()
        
    }
    @IBAction func onAddPressed(sender: AnyObject){
        if self.buttonsEnabled != false {
            processOperation(operation: .Add)
            displayRunningNumber += " + "
//            processOperation(operation: currentOperation)
            calculationLbl.text = displayRunningNumber
        }
       
        self.disableBtns()
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
       
            processOperation(operation: currentOperation)
    
    }
    
    func disableBtns(){
        divideBtn.isUserInteractionEnabled = false
        subtractBtn.isUserInteractionEnabled = false
        multiplyBtn.isUserInteractionEnabled = false
        addBtn.isUserInteractionEnabled = false
        
        self.buttonsEnabled = false
    }
    
    func enableBtns(){
        divideBtn.isUserInteractionEnabled = true
        subtractBtn.isUserInteractionEnabled = true
        multiplyBtn.isUserInteractionEnabled = true
        addBtn.isUserInteractionEnabled = true
        
        self.buttonsEnabled = true
    }
    
    func reCalc() {
        if currentOperation != Operation.Empty && runningNumber != "" && leftValStr != ""  {
            rightValStr = runningNumber
            processOperation(operation: currentOperation)
        }
        print("reCalc")
    }

    
}

