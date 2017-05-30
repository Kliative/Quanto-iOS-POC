//
//  ViewController.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 04/05/2017.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, baseDataSentDelegate, destDataSentDelegate, testDataSentDelegate {
    
    
    var cityData = [CityData]()

    
    
    var countryCity: Dictionary<String, AnyObject>!
    var cityProds: Dictionary<String, AnyObject>!
    //Operation Buttons
    @IBOutlet weak var divideBtn: UIButton!
    @IBOutlet weak var subtractBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var decimalBtn: UIButton!
    
    var testRef: FIRDatabaseReference!
    
    @IBOutlet weak var calculationLbl: UILabel!
    @IBOutlet weak var baseCurrencyBtn: UIButton!
    @IBOutlet weak var baseCurrencyLbl: UILabel!
    
    
    @IBOutlet weak var destinationCurrencyBtn: UIButton!
    @IBOutlet weak var destinationCurrencyLbl: UILabel!
    
    @IBOutlet weak var testCurrencyBtn: UIButton!
    
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
    
    var buttonsEnabled: Bool!
    var decimalEnabled: Bool!
    
    var baseCurrSel: String!
    var destCurrSel: String!
    var testCurrSel: String!
    
    var sortedCurrency:[String] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.ds.REF_COUNTRIES.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshot {
//                    print("----: \(snap)")
                    if let countryDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        
                        let countryDataSnap = CountryData(countryName:key,
                                                         currencyCode: countryDict["ISO4217_currency_alphabetic_code"] as! String,
                                                         currencyName: countryDict["ISO4217_currency_name"] as! String,
                                                         currencySymbol: countryDict["ISO4217_currency_symbol"] as! String,
                                                         productData:countryDict["products"] as! Dictionary<String, AnyObject>,
                                                         cities:countryDict["cities"] as! [String])
                        
                        self.countryData.append(countryDataSnap)
                        
                        self.countryNameArray.append(key)
                        
                        self.cityNameArray = countryDict["cities"] as! [String]
                        
                        
                        
//                        self.getProdData(countryKey:key, cityKey: "\(self.cityNameArray[0])")
                        self.getCitiesProd(countryKey:key)
//                        print(self.cityProds["\(self.cityNameArray[0])"]?["Coke"]!)
//                        self.productsPrices = self.cityProds["\(self.cityNameArray[0])"]?["Coke"]! as! Dictionary<String, AnyObject>
//                        
//                        
//                        
//                        print(self.productsPrices["low"]!)
//                        print(countryDataSnap.countryName)
//                        print(countryDataSnap.currencyCode)
//                        print(countryDataSnap.currencyName)
//                        print(countryDataSnap.currencySymbol)
//                        print(countryDataSnap.coke["high"]!)
//                        print(countryDataSnap.cities)
                        
                        
                    }
                }
            }
        })
        
        currentRates = CurrentExchange()
        currentRates.downloadExchangeRates {}
        
        self.decimalEnabled = true
        decimalBtn.isUserInteractionEnabled = true
        
        calculationLbl.text = "0"
        baseCurrencyLbl.text = "0"
        destinationCurrencyLbl.text = "Select Countries to Convert"
        destinationCurrencyLbl.textColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha:0.2)
        
        self.disableBtns()
        
        if self.destCurrSel == nil || self.baseCurrSel == nil {
            self.destCurrSel = "ZAR"
            self.baseCurrSel = "GBP"
            self.baseCurrencyBtn.setTitle("GBP", for: .normal)
            self.destinationCurrencyBtn.setTitle("ZAR", for: .normal)
            
        }
        
    }
    
    func getProdData(countryKey:String, cityKey: String){
        DataService.ds.REF_CITIES.child(countryKey).child(cityKey).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshot {
//                    print("----: \(snap)")
                    if let cityDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        print(key)
                        print(cityDict)
                        self.cityProds = cityDict
//                        print(self.cityProds)
                    }
                }
            }
        })
    }
    
    func getCitiesProd(countryKey:String){
        DataService.ds.REF_CITIES.child(countryKey).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshot {
                    //                    print("----: \(snap)")
                    if let countryCityDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
//                        print(key)
//                        print(countryCityDict)
                        
                        let cheese = CityData(cityName:key, productData:countryCityDict)
//                        self.countryCity = countryCityDict
                        //                        print(self.cityProds)
                    }
                }
            }
        })
    }
    
    @IBAction func numberPressed(sender: UIButton){
        
        runningNumber += "\(sender.tag)"
        displayRunningNumber += "\(sender.tag)"
        calculationLbl.text = displayRunningNumber
        
        if currentOperation == Operation.Empty {
            result = runningNumber
        }
        baseCurrencyLbl.text = result
        
        if currentOperation != Operation.Empty {
            liveOperation(operation: currentOperation)
        }
        
        self.enableBtns()
        
        //Does Converstion
        if self.destCurrSel != nil && self.baseCurrSel != nil && result != "" {
            
            let stringResult = Double(result)!
            let priceToConver = Double(round(stringResult))
            let convertedAmount = Double(self.currentRates.doConvertion(dest: self.destCurrSel, base: self.baseCurrSel, price: priceToConver))!
            
            destinationCurrencyLbl.text = "\(Double(round(convertedAmount)))"
            destinationCurrencyLbl.textColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha:1)
        }
        
    }
    
    @IBAction func clearButton(_ sender: Any) {
        
        
        if displayRunningNumber != "" && runningNumber != "" {
            displayRunningNumber.remove(at: displayRunningNumber.index(before: displayRunningNumber.endIndex))
            runningNumber.remove(at: runningNumber.index(before: runningNumber.endIndex))
            liveOperation(operation: currentOperation)
            baseCurrencyLbl.text = result
            calculationLbl.text = displayRunningNumber
            
            if self.destCurrSel != nil && self.baseCurrSel != nil && result != "" {
                let stringResult = Double(result)!
                let priceToConver = Double(round(stringResult))
                
                let convertedAmount = Double(self.currentRates.doConvertion(dest: self.destCurrSel, base: self.baseCurrSel, price: priceToConver))!
                
                destinationCurrencyLbl.text = "\(Double(round(convertedAmount)))"
            }
        } else {
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
            
        }
    }

    
    
    @IBAction func baseCurrencyBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "baseCurrVCSegue", sender: self)
    }
    
    @IBAction func destCurrencyBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "destCurrVCSegue", sender: self)
    }
    
    @IBAction func testCurrencyBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "testCurrVCSegue", sender: self)
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
            calculationLbl.text = displayRunningNumber
        }
        self.disableBtns()
        
    }
    @IBAction func onSubtractPressed(sender: AnyObject){
        if self.buttonsEnabled != false {
            processOperation(operation: .Subtract)
            displayRunningNumber += " - "
            calculationLbl.text = displayRunningNumber
        }
        self.disableBtns()
        
    }
    @IBAction func onAddPressed(sender: AnyObject){
        if self.buttonsEnabled != false {
            processOperation(operation: .Add)
            displayRunningNumber += " + "
            calculationLbl.text = displayRunningNumber
        }
       
        self.disableBtns()
    }
    
    @IBAction func decimalBtnPressed(_ sender: Any) {
        if self.decimalEnabled == true {
            runningNumber += "."
            displayRunningNumber += "."
            self.decimalEnabled = false
            decimalBtn.isUserInteractionEnabled = false
        }

    }

    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        
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
        if segue.identifier == "testCurrVCSegue" {
            let testVC: TestVC = segue.destination as! TestVC
            testVC.delegate = self
        }
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
        //Currently Always returns nil for all
//        if self.destCurrSel != nil && self.baseCurrSel != nil && result != "" {
//            let stringResult = Double(result)!
//            let priceToConver = Double(round(stringResult))
//            
//            let convertedAmount = Double(self.currentRates.doConvertion(dest: self.destCurrSel, base: self.baseCurrSel, price: priceToConver))!
//            
//            destinationCurrencyLbl.text = "\(Double(round(convertedAmount)))"
//        }
//                print("-----------Recalc Pressed---------------")
//                print("runningNumber = \(runningNumber)")
//                print("--------------------------------")
//                print("leftValStr = \(leftValStr)")
//                print("currentOperation = \(currentOperation)")
//                print("rightValStr = \(rightValStr)")
//                print("result = \(result)")
        
        
        print("reCalc")
    }
    
    
    func userDidEnterBaseData(data: String) {
        self.baseCurrencyBtn.setTitle(data, for: .normal)
        self.baseCurrSel = data
        
    }
    
    func userDidEnterTestData(data: String) {
        self.testCurrencyBtn.setTitle(data, for: .normal)
        self.testCurrSel = data
        
    }
    
    func userDidEnterDestData(data: String) {
        self.destinationCurrencyBtn.setTitle(data, for: .normal)
        self.destCurrSel = data
        
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
        self.decimalEnabled = true
        decimalBtn.isUserInteractionEnabled = true
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
        //        print("-----------Operation Pressed---------------")
        //        print("runningNumber = \(runningNumber)")
        //        print("--------------------------------")
        //        print("leftValStr = \(leftValStr)")
        //        print("currentOperation = \(currentOperation)")
        //        print("rightValStr = \(rightValStr)")
        //        print("result = \(result)")
    }

    
}

