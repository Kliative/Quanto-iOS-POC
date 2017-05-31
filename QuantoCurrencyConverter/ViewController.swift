//
//  ViewController.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 04/05/2017.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, baseDataSentDelegate, destDataSentDelegate, testDataSentDelegate, testBaseDataSentDelegate,UITableViewDataSource, UITableViewDelegate {
    
    var cityData = [CityData]()
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var baseTesttableView:UITableView!
    var countryCity: Dictionary<String, AnyObject>!
    var cityProds: Dictionary<String, AnyObject>!
    //Operation Buttons
    @IBOutlet weak var divideBtn: UIButton!
    @IBOutlet weak var subtractBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var decimalBtn: UIButton!
    
    
    @IBOutlet weak var calculationLbl: UILabel!
    @IBOutlet weak var baseCurrencyBtn: UIButton!
    @IBOutlet weak var baseCurrencyLbl: UILabel!
    
    @IBOutlet weak var destinationCurrencyBtn: UIButton!
    @IBOutlet weak var destinationCurrencyLbl: UILabel!
    
//    Test Data for pulling object 
    @IBOutlet weak var testCurrencyBtn: UIButton!
    @IBOutlet weak var testBaseCurrencyBtn: UIButton!
    var baseCities:[String] = []
    var cities:[String] = []
    @IBOutlet weak var mcmealDestLbl: UILabel!
    @IBOutlet weak var mealDestLbl: UILabel!
    @IBOutlet weak var domBeerDestLbl: UILabel!
    @IBOutlet weak var cokeDestLbl: UILabel!
    
    @IBOutlet weak var mcmealBaseLbl: UILabel!
    @IBOutlet weak var mealBaseLbl: UILabel!
    @IBOutlet weak var domBeerBaseLbl: UILabel!
    @IBOutlet weak var cokeBaseLbl: UILabel!
    
    var baseCurrSymbol: String!
    var destCurrSymbol: String!
    
    
    
    var countryKey:String!
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
//    
    var sortedCurrency:[String] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        baseTesttableView.delegate = self
        baseTesttableView.dataSource = self
        
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
            self.baseCurrencyBtn.setTitle("United Kingdom [GBP]", for: .normal)
            self.destinationCurrencyBtn.setTitle("South Africa [ZAR]", for: .normal)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for:indexPath) as? CitiesCell{
                cell.configureCityCell(cityName: self.cities[indexPath.row])
                
                return cell
            } else {
                return CitiesCell()
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CityBaseCell", for:indexPath) as? CitiesCell{
                cell.configureCityCell(cityName: self.baseCities[indexPath.row])
                
                return cell
            } else {
                return CitiesCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
                return self.cities.count
        } else {
                return self.baseCities.count
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.tableView {
            self.getCitiesProd(countryKey: self.countryKey, cityKey: self.cities[indexPath.row])
        } else {
            self.getBaseCitiesProd(countryKey: self.countryKey, cityKey: self.baseCities[indexPath.row])
        }
        
    }
    
    func userDidEnterTestData(data: CountryData) {
        self.countryKey = data.countryName
        self.testCurrencyBtn.setTitle("\(data.countryName) [\(data.currencyCode)]", for: .normal)
        self.destCurrSel = data.currencyCode
        self.destCurrSymbol = data.currencySymbol
        self.cities = data.cities
        self.tableView.reloadData()
    }
    
    func userDidEnterTestBaseData(data: CountryData) {
        self.countryKey = data.countryName
        self.testBaseCurrencyBtn.setTitle("\(data.countryName) [\(data.currencyCode)]", for: .normal)
        self.baseCurrSel = data.currencyCode
        self.baseCities = data.cities
        self.baseCurrSymbol = data.currencySymbol
        self.baseTesttableView.reloadData()
    }
    
    func getCitiesProd(countryKey:String, cityKey: String){
        DataService.ds.REF_CITIES.child(countryKey).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshot {
                    if let countryCityDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let cityProdData = CityData(cityName:key, productData:countryCityDict)
                        self.cityData.append(cityProdData)
                        for var i in (0..<self.cityData.count){
                            if (self.cityData[i].cityName == cityKey)
                            {
                                self.cokeDestLbl.text = "\(self.destCurrSymbol!) \(self.cityData[i].coke["norm"]!)"
                                self.domBeerDestLbl.text = "\(self.destCurrSymbol!) \(self.cityData[i].domBeer["norm"]!)"
                                self.mealDestLbl.text = "\(self.destCurrSymbol!) \(self.cityData[i].meal["norm"]!)"
                                self.mcmealDestLbl.text = "\(self.destCurrSymbol!) \(self.cityData[i].mcMeal["norm"]!)"
                                
                            }
                        }
                    }
                }
            }
        })
    }
    
    func getBaseCitiesProd(countryKey:String, cityKey: String){
        DataService.ds.REF_CITIES.child(countryKey).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshot {
                    if let countryCityDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let cityProdData = CityData(cityName:key, productData:countryCityDict)
                        self.cityData.append(cityProdData)
                        for var i in (0..<self.cityData.count){
                            if (self.cityData[i].cityName == cityKey)
                            {
                                self.cokeBaseLbl.text = "\(self.baseCurrSymbol!) \(self.cityData[i].coke["norm"]!)"
                                self.domBeerBaseLbl.text = "\(self.baseCurrSymbol!) \(self.cityData[i].domBeer["norm"]!)"
                                self.mealBaseLbl.text = "\(self.baseCurrSymbol!) \(self.cityData[i].meal["norm"]!)"
                                self.mcmealBaseLbl.text = "\(self.baseCurrSymbol!) \(self.cityData[i].mcMeal["norm"]!)"
                                
                            }
                        }
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
        if segue.identifier == "testBaseCurrVCSegue" {
            let testBaseVC: TestBaseVC = segue.destination as! TestBaseVC
            testBaseVC.delegate = self
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
//        Currently Always returns nil for all
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
//        
//        
        print("Supposed to reCalc numbers on screen based on new selection")
    }
    
    
    func userDidEnterBaseData(data: String) {
        self.baseCurrencyBtn.setTitle(data, for: .normal)
        self.baseCurrSel = data
        
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

