//
//  Exchange.swift
//  CurrEx
//
//  Created by Tawanda Kanyangarara on 2017/05/16.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class CurrentExchange {
    var exData = [ExRate]()
    var timeStamp = [Timestamp]()
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
            
            switch result {
            case .success:
                //                    print(response.value!)
                if let dict = response.value as? Dictionary<String, AnyObject> {
                    
//                    let timestamp = dict["timestamp"]
//                    print(timestamp)
                    if let latestRates = dict["rates"] as? Dictionary<String, Double> {
                        
                        self._rates = latestRates
                        //Assign Currency Strings to Array for tableView
                        for (key, value) in latestRates {
                            self.myCurrency.append(key)
                            
                            //not necessary
                            self.myValues.append(value)
                        }
                        
                        //                    self.sortedCurrency = self.myCurrency.sorted()
                        self.sortedCurrency = self.myCurrency.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                        //                    print(self.sortedCurrency[0])
                       
                            
                            let exRate = ExRate(context: context)
//                            let timeSt = Timestamp(context: context)
//                            timeSt.time = timestamp as! NSObject
                        
                       
                            

                                
                                exRate.setValue(Double(self._rates["AED"]!), forKey: "aed")
                                exRate.setValue(Double(self._rates["AFN"]!), forKey: "afn")
                                exRate.setValue(Double(self._rates["ALL"]!), forKey: "all")
                                exRate.setValue(Double(self._rates["AMD"]!), forKey: "amd")
                                exRate.setValue(Double(self._rates["ANG"]!), forKey: "ang")
                                exRate.setValue(Double(self._rates["AOA"]!), forKey: "aoa")
                                exRate.setValue(Double(self._rates["ARS"]!), forKey: "ars")
                                exRate.setValue(Double(self._rates["AUD"]!), forKey: "aud")
                                exRate.setValue(Double(self._rates["AWG"]!), forKey: "awg")
                                exRate.setValue(Double(self._rates["AZN"]!), forKey: "azn")
                                exRate.setValue(Double(self._rates["BAM"]!), forKey: "bam")
                                exRate.setValue(Double(self._rates["BBD"]!), forKey: "bbd")
                                exRate.setValue(Double(self._rates["BDT"]!), forKey: "bdt")
                                exRate.setValue(Double(self._rates["BGN"]!), forKey: "bgn")
                                exRate.setValue(Double(self._rates["BHD"]!), forKey: "bhd")
                                exRate.setValue(Double(self._rates["BIF"]!), forKey: "bif")
                                exRate.setValue(Double(self._rates["BMD"]!), forKey: "bmd")
                                exRate.setValue(Double(self._rates["BND"]!), forKey: "bnd")
                                exRate.setValue(Double(self._rates["BOB"]!), forKey: "bob")
                                exRate.setValue(Double(self._rates["BRL"]!), forKey: "brl")
                                exRate.setValue(Double(self._rates["BSD"]!), forKey: "bsd")
                                exRate.setValue(Double(self._rates["BTC"]!), forKey: "btc")
                                exRate.setValue(Double(self._rates["BTN"]!), forKey: "btn")
                                exRate.setValue(Double(self._rates["BWP"]!), forKey: "bwp")
                                exRate.setValue(Double(self._rates["BYN"]!), forKey: "byn")
                                exRate.setValue(Double(self._rates["BZD"]!), forKey: "bzd")
                                exRate.setValue(Double(self._rates["CAD"]!), forKey: "cad")
                                exRate.setValue(Double(self._rates["CDF"]!), forKey: "cdf")
                                exRate.setValue(Double(self._rates["CHF"]!), forKey: "chf")
                                exRate.setValue(Double(self._rates["CLF"]!), forKey: "clf")
                                exRate.setValue(Double(self._rates["CLP"]!), forKey: "clp")
                                exRate.setValue(Double(self._rates["CNH"]!), forKey: "cnh")
                                exRate.setValue(Double(self._rates["CNY"]!), forKey: "cny")
                                exRate.setValue(Double(self._rates["COP"]!), forKey: "cop")
                                exRate.setValue(Double(self._rates["CRC"]!), forKey: "crc")
                                exRate.setValue(Double(self._rates["CUC"]!), forKey: "cuc")
                                exRate.setValue(Double(self._rates["CUP"]!), forKey: "cup")
                                exRate.setValue(Double(self._rates["CVE"]!), forKey: "cve")
                                exRate.setValue(Double(self._rates["CZK"]!), forKey: "czk")
                                exRate.setValue(Double(self._rates["DJF"]!), forKey: "djf")
                                exRate.setValue(Double(self._rates["DKK"]!), forKey: "dkk")
                                exRate.setValue(Double(self._rates["DOP"]!), forKey: "dop")
                                exRate.setValue(Double(self._rates["DZD"]!), forKey: "dzd")
                                exRate.setValue(Double(self._rates["EGP"]!), forKey: "egp")
                                exRate.setValue(Double(self._rates["ERN"]!), forKey: "ern")
                                exRate.setValue(Double(self._rates["ETB"]!), forKey: "etb")
                                exRate.setValue(Double(self._rates["EUR"]!), forKey: "eur")
                                exRate.setValue(Double(self._rates["FJD"]!), forKey: "fjd")
                                exRate.setValue(Double(self._rates["FKP"]!), forKey: "fkp")
                                exRate.setValue(Double(self._rates["GBP"]!), forKey: "gbp")
                                exRate.setValue(Double(self._rates["GEL"]!), forKey: "gel")
                                exRate.setValue(Double(self._rates["GGP"]!), forKey: "ggp")
                                exRate.setValue(Double(self._rates["GHS"]!), forKey: "ghs")
                                exRate.setValue(Double(self._rates["GIP"]!), forKey: "gip")
                                exRate.setValue(Double(self._rates["GMD"]!), forKey: "gmd")
                                exRate.setValue(Double(self._rates["GNF"]!), forKey: "gnf")
                                exRate.setValue(Double(self._rates["GTQ"]!), forKey: "gtq")
                                exRate.setValue(Double(self._rates["GYD"]!), forKey: "gyd")
                                exRate.setValue(Double(self._rates["HKD"]!), forKey: "hkd")
                                exRate.setValue(Double(self._rates["HNL"]!), forKey: "hnl")
                                exRate.setValue(Double(self._rates["HRK"]!), forKey: "hrk")
                                exRate.setValue(Double(self._rates["HTG"]!), forKey: "htg")
                                exRate.setValue(Double(self._rates["HUF"]!), forKey: "huf")
                                exRate.setValue(Double(self._rates["IDR"]!), forKey: "idr")
                                exRate.setValue(Double(self._rates["ILS"]!), forKey: "ils")
                                exRate.setValue(Double(self._rates["IMP"]!), forKey: "imp")
                                exRate.setValue(Double(self._rates["INR"]!), forKey: "inr")
                                exRate.setValue(Double(self._rates["IQD"]!), forKey: "iqd")
                                exRate.setValue(Double(self._rates["IRR"]!), forKey: "irr")
                                exRate.setValue(Double(self._rates["ISK"]!), forKey: "isk")
                                exRate.setValue(Double(self._rates["JEP"]!), forKey: "jep")
                                exRate.setValue(Double(self._rates["JMD"]!), forKey: "jmd")
                                exRate.setValue(Double(self._rates["JOD"]!), forKey: "jod")
                                exRate.setValue(Double(self._rates["JPY"]!), forKey: "jpy")
                                exRate.setValue(Double(self._rates["KES"]!), forKey: "kes")
                                exRate.setValue(Double(self._rates["KGS"]!), forKey: "kgs")
                                exRate.setValue(Double(self._rates["KHR"]!), forKey: "khr")
                                exRate.setValue(Double(self._rates["KMF"]!), forKey: "kmf")
                                exRate.setValue(Double(self._rates["KPW"]!), forKey: "kpw")
                                exRate.setValue(Double(self._rates["KRW"]!), forKey: "krw")
                                exRate.setValue(Double(self._rates["KWD"]!), forKey: "kwd")
                                exRate.setValue(Double(self._rates["KYD"]!), forKey: "kyd")
                                exRate.setValue(Double(self._rates["KZT"]!), forKey: "kzt")
                                exRate.setValue(Double(self._rates["LAK"]!), forKey: "lak")
                                exRate.setValue(Double(self._rates["LBP"]!), forKey: "lbp")
                                exRate.setValue(Double(self._rates["LKR"]!), forKey: "lkr")
                                exRate.setValue(Double(self._rates["LRD"]!), forKey: "lrd")
                                exRate.setValue(Double(self._rates["LSL"]!), forKey: "lsl")
                                exRate.setValue(Double(self._rates["LYD"]!), forKey: "lyd")
                                exRate.setValue(Double(self._rates["MAD"]!), forKey: "mad")
                                exRate.setValue(Double(self._rates["MDL"]!), forKey: "mdl")
                                exRate.setValue(Double(self._rates["MGA"]!), forKey: "mga")
                                exRate.setValue(Double(self._rates["MKD"]!), forKey: "mkd")
                                exRate.setValue(Double(self._rates["MMK"]!), forKey: "mmk")
                                exRate.setValue(Double(self._rates["MNT"]!), forKey: "mnt")
                                exRate.setValue(Double(self._rates["MOP"]!), forKey: "mop")
                                exRate.setValue(Double(self._rates["MRO"]!), forKey: "mro")
                                exRate.setValue(Double(self._rates["MUR"]!), forKey: "mur")
                                exRate.setValue(Double(self._rates["MVR"]!), forKey: "mvr")
                                exRate.setValue(Double(self._rates["MWK"]!), forKey: "mwk")
                                exRate.setValue(Double(self._rates["MXN"]!), forKey: "mxn")
                                exRate.setValue(Double(self._rates["MYR"]!), forKey: "myr")
                                exRate.setValue(Double(self._rates["MZN"]!), forKey: "mzn")
                                exRate.setValue(Double(self._rates["NAD"]!), forKey: "nad")
                                exRate.setValue(Double(self._rates["NGN"]!), forKey: "ngn")
                                exRate.setValue(Double(self._rates["NIO"]!), forKey: "nio")
                                exRate.setValue(Double(self._rates["NOK"]!), forKey: "nok")
                                exRate.setValue(Double(self._rates["NPR"]!), forKey: "npr")
                                exRate.setValue(Double(self._rates["NZD"]!), forKey: "nzd")
                                exRate.setValue(Double(self._rates["OMR"]!), forKey: "omr")
                                exRate.setValue(Double(self._rates["PAB"]!), forKey: "pab")
                                exRate.setValue(Double(self._rates["PEN"]!), forKey: "pen")
                                exRate.setValue(Double(self._rates["PGK"]!), forKey: "pgk")
                                exRate.setValue(Double(self._rates["PHP"]!), forKey: "php")
                                exRate.setValue(Double(self._rates["PKR"]!), forKey: "pkr")
                                exRate.setValue(Double(self._rates["PLN"]!), forKey: "pln")
                                exRate.setValue(Double(self._rates["PYG"]!), forKey: "pyg")
                                exRate.setValue(Double(self._rates["QAR"]!), forKey: "qar")
                                exRate.setValue(Double(self._rates["RON"]!), forKey: "ron")
                                exRate.setValue(Double(self._rates["RSD"]!), forKey: "rsd")
                                exRate.setValue(Double(self._rates["RUB"]!), forKey: "rub")
                                exRate.setValue(Double(self._rates["RWF"]!), forKey: "rwf")
                                exRate.setValue(Double(self._rates["SAR"]!), forKey: "sar")
                                exRate.setValue(Double(self._rates["SBD"]!), forKey: "sbd")
                                exRate.setValue(Double(self._rates["SCR"]!), forKey: "scr")
                                exRate.setValue(Double(self._rates["SDG"]!), forKey: "sdg")
                                exRate.setValue(Double(self._rates["SEK"]!), forKey: "sek")
                                exRate.setValue(Double(self._rates["SGD"]!), forKey: "sgd")
                                exRate.setValue(Double(self._rates["SHP"]!), forKey: "shp")
                                exRate.setValue(Double(self._rates["SLL"]!), forKey: "sll")
                                exRate.setValue(Double(self._rates["SOS"]!), forKey: "sos")
                                exRate.setValue(Double(self._rates["SRD"]!), forKey: "srd")
                                exRate.setValue(Double(self._rates["SSP"]!), forKey: "ssp")
                                exRate.setValue(Double(self._rates["STD"]!), forKey: "std")
                                exRate.setValue(Double(self._rates["SVC"]!), forKey: "svc")
                                exRate.setValue(Double(self._rates["SYP"]!), forKey: "syp")
                                exRate.setValue(Double(self._rates["SZL"]!), forKey: "szl")
                                exRate.setValue(Double(self._rates["THB"]!), forKey: "thb")
                                exRate.setValue(Double(self._rates["TJS"]!), forKey: "tjs")
                                exRate.setValue(Double(self._rates["TMT"]!), forKey: "tmt")
                                exRate.setValue(Double(self._rates["TND"]!), forKey: "tnd")
                                exRate.setValue(Double(self._rates["TOP"]!), forKey: "top")
                                exRate.setValue(Double(self._rates["TRY"]!), forKey: "try")
                                exRate.setValue(Double(self._rates["TTD"]!), forKey: "ttd")
                                exRate.setValue(Double(self._rates["TWD"]!), forKey: "twd")
                                exRate.setValue(Double(self._rates["TZS"]!), forKey: "tzs")
                                exRate.setValue(Double(self._rates["UAH"]!), forKey: "uah")
                                exRate.setValue(Double(self._rates["UGX"]!), forKey: "ugx")
                                exRate.setValue(Double(self._rates["USD"]!), forKey: "usd")
                                exRate.setValue(Double(self._rates["UYU"]!), forKey: "uyu")
                                exRate.setValue(Double(self._rates["UZS"]!), forKey: "uzs")
                                exRate.setValue(Double(self._rates["VEF"]!), forKey: "vef")
                                exRate.setValue(Double(self._rates["VND"]!), forKey: "vnd")
                                exRate.setValue(Double(self._rates["VUV"]!), forKey: "vuv")
                                exRate.setValue(Double(self._rates["WST"]!), forKey: "wst")
                                exRate.setValue(Double(self._rates["XAF"]!), forKey: "xaf")
                                exRate.setValue(Double(self._rates["XAG"]!), forKey: "xag")
                                exRate.setValue(Double(self._rates["XAU"]!), forKey: "xau")
                                exRate.setValue(Double(self._rates["XCD"]!), forKey: "xcd")
                                exRate.setValue(Double(self._rates["XDR"]!), forKey: "xdr")
                                exRate.setValue(Double(self._rates["XOF"]!), forKey: "xof")
                                exRate.setValue(Double(self._rates["XPD"]!), forKey: "xpd")
                                exRate.setValue(Double(self._rates["XPF"]!), forKey: "xpf")
                                exRate.setValue(Double(self._rates["XPT"]!), forKey: "xpt")
                                exRate.setValue(Double(self._rates["YER"]!), forKey: "yer")
                                exRate.setValue(Double(self._rates["ZAR"]!), forKey: "zar")
                                exRate.setValue(Double(self._rates["ZMW"]!), forKey: "zmw")
                                exRate.setValue(Double(self._rates["ZWL"]!), forKey: "zwl")
                                //                                    print(exRate)
                                
                                //math operators
                                print(exRate.gbp + exRate.gbp)
                                //Lowercase for CoreData Attribute
                                let string = "GBP"
                                print(exRate.value(forKey: string.lowercased())!)
                                ad.saveContext()
                     
                        
                    }
                    completed()
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    
    //Makes it possible to convert from any curreny --> Returns String
    func doConvertion(dest: String, base: String, price: Float) -> String{
        var calcResult = ""
        print("\(base) : \(dest) : \(price)")
        do {
            self.exData = try context.fetch(ExRate.fetchRequest())
            print(self.exData)
          
            
            for exRate in self.exData {
                let destCurrRate = exRate.value(forKey: dest.lowercased())!
                let baseCurrRate = exRate.value(forKey: base.lowercased())!
                
                let priceToCalc = price
                
                //Decommissions USD as Base Currency and Allows base:String to act as Base Currency
                let baseToDollar = 1 / Double(String(describing:baseCurrRate))!
                let finalConv = Float(baseToDollar*Double(String(describing:destCurrRate))!)
                calcResult = "\(finalConv*priceToCalc)"
            }
        }
        catch{
            
        }
        
        return calcResult
       
        
        
    }
    
}
