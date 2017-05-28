//
//  Exchange.swift
//  CurrEx
//
//  Created by Tawanda Kanyangarara on 2017/05/16.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import Foundation
import Alamofire

class CurrentExchange {

    var _rates: Dictionary<String, Double>!
    
    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    var sortedCurrency:[String] = []
    
    var rates: Dictionary<String, Double>{
        if _rates == nil {
            _rates = ["":0.0 as Double]
        }
        return _rates
    }
    
    
    func downloadExchangeRates(completed: @escaping DownloadComplete) {
        
        Alamofire.request(LASTEST_RATES).responseJSON { response in
            let result = response.result
            //Get JSON data from OpenX
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let latestRates = dict["rates"] as? Dictionary<String, Double> {
                    self._rates = latestRates
//                    print(self._rates)
                    
                    //Assign Currency Strings to Array for tableView
                    for (key, value) in latestRates {
                        self.myCurrency.append(key)
                        
                        //not necessary
                        self.myValues.append(value)
                    }
                    
//                    self.sortedCurrency = self.myCurrency.sorted()
                    self.sortedCurrency = self.myCurrency.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
//                    print(self.sortedCurrency[0])
                   
                }
            }
            completed()
        }
    }
    
    
    //Makes it possible to convert from any curreny --> Returns String
    func doConvertion(dest: String, base: String, price: Double) -> String{
        
        let destCurrRate = self.rates[dest]
        let baseCurrRate = self.rates[base]
        
        let price = price
        
        //Decommissions USD as Base Currency and Allows base:String to act as Base Currency
        let baseToDollar = 1 / baseCurrRate!
        let finalConv = baseToDollar*destCurrRate!
        let calcResult = "\(finalConv*price)"
        
        return calcResult
    }
}
