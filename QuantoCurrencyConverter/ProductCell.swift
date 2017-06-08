//
//  ProductCell.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/06/01.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    var currentRates: CurrentExchange!
    
    @IBOutlet weak var productType:UILabel!
    @IBOutlet weak var destPrice:UILabel!
    @IBOutlet weak var basePrice:UILabel!
    @IBOutlet weak var priceDifference:UILabel!
    @IBOutlet weak var differenceLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        currentRates = CurrentExchange()
        
    }

    func configureProductCell(productRange: String, baseCurr: String, destCurr:String, destCurrSymbol:String, baseCurrSymbol:String, indexPath: Int, baseCityProdList:Dictionary<String, AnyObject>, destCityProdList:Dictionary<String, AnyObject>){
        
        currentRates.downloadExchangeRates {
            let baseProdObj = Array(baseCityProdList)[indexPath]
            let basePriceString = Float(baseProdObj.value[productRange] as! String)!
            
            let destProdObj = Array(destCityProdList)[indexPath]
            let destPriceString = Float(destProdObj.value[productRange] as! String)!
            
            if baseProdObj.key == destProdObj.key {
                
                self.productType.text = baseProdObj.key
                
                self.basePrice.text = "\(baseCurrSymbol)\(basePriceString)"
                self.destPrice.text = "\(destCurrSymbol)\(destPriceString)"
                
                let convertedPrice = Float(self.currentRates.doConvertion(dest: baseCurr, base: destCurr, price: destPriceString))!
                
                let calc = basePriceString - convertedPrice
                
                self.priceDifference.text = "\(baseCurrSymbol)\(String(format: "%.2f", abs(calc)))"
                let basePriceText = basePriceString
                let difPrice = Float(abs(calc))
                
                
                if difPrice >= basePriceText {
                    self.differenceLbl.text = "More Expensive"
                } else {
                    self.differenceLbl.text = "Less Expensive"
                }
            }
        
        }
        
        
    }

}
