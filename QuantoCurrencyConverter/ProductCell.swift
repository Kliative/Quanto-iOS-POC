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
        
        let baseProdObj = Array(baseCityProdList)[indexPath]
        let basePriceString = Float(baseProdObj.value[productRange] as! String)!
        
        let destProdObj = Array(destCityProdList)[indexPath]
        let destPriceString = Float(destProdObj.value[productRange] as! String)!
        
        print("\(baseCurr)\(basePriceString) - \(destCurr) \(destPriceString) | \(baseProdObj.key) + \(destProdObj.key)")
        if baseProdObj.key == destProdObj.key {
            
            productType.text = baseProdObj.key
            
            basePrice.text = "\(baseCurrSymbol)\(basePriceString)"
            destPrice.text = "\(destCurrSymbol)\(destPriceString)"

            //NEED TO FIX CALCULATIONS
            
//                    let convertedPrice = Double(self.currentRates.doConvertion(dest: destCurr, base: baseCurr, price: destPriceString))!
//                    print(convertedPrice)
            
            //supposed to be convertedPrice instead of destPriceString
            let calc = basePriceString - destPriceString
            
            priceDifference.text = "\(baseCurrSymbol)\(String(format: "%.2f", calc))"
            let basePriceText = basePriceString
            let difPrice = Float(calc)
            
            
            if difPrice >= basePriceText {
                differenceLbl.text = "More Expensive"
            } else {
                differenceLbl.text = "Less Expensive"
            }
        }
    }

}
