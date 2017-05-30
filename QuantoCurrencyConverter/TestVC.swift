//
//  TestVC.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/05/30.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import UIKit
import FirebaseDatabase



protocol testDataSentDelegate {
    func userDidEnterTestData(data: String)
}



class TestVC:  UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var countryData = [CountryData]()
    
    var cityNameArray:[String] = []
    var countryNameArray:[String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    
    
    var filterData = [String]()
    
    
    var sortedCurrency:[String] = []
    
    var currentRates: CurrentExchange!
    var delegate: testDataSentDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        DataService.ds.REF_COUNTRIES.observe(.value, with: { (snapshot) in
            self.countryData = []
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshot {
                    
                    if let countryDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        
                        let countryDataSnap = CountryData(countryName:key,
                                                          currencyCode: countryDict["ISO4217_currency_alphabetic_code"] as! String,
                                                          currencyName: countryDict["ISO4217_currency_name"] as! String,
                                                          currencySymbol: countryDict["ISO4217_currency_symbol"] as! String,
                                                          productData:countryDict["products"] as! Dictionary<String, AnyObject>,
                                                          cities:countryDict["cities"] as! [String])
                        
                        self.countryData.append(countryDataSnap)
                        
                        let cc = self.countryData[0]
                        print(cc.countryName)
                        self.countryNameArray.append(key)
                        
                        self.cityNameArray = countryDict["cities"] as! [String]

                        
                    }
                }
            }
            self.tableView.reloadData()
        })
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Assign correct Cell to countryData indexPath.row
        let countryData = self.countryData[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "testCurrCell", for:indexPath) as? CurrencyCell{
            
        
            //sends throught country Name to cells, create better cellconfig and add more data
            cell.configureCurrencyCell(currencyName: countryData.countryName)
            
            return cell
            
        } else {
            return CurrencyCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filterData.count
        }
        
        return countryData.count
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Assign correct Cell to countryData indexPath.row
        let countryData = self.countryData[indexPath.row]
            //send back the currency Code, see if you can send the whole object :) :)
            let data = countryData.currencyCode
            delegate?.userDidEnterTestData(data: data)
      
        dismiss(animated: true) {
            ViewController().reCalc()
        }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else{
            isSearching = true
            
            let lower = searchBar.text!.uppercased()
            filterData = self.sortedCurrency.filter({$0.range(of: lower) != nil})
            tableView.reloadData()
        }
        
    }
    
    @IBAction func dismissBaseVCPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
