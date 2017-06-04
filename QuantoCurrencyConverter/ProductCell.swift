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
    }

    func configureProductCell(baseCity:CityData, destCity:CityData, productRange: String, baseCurr: String, destCurr:String, destCurrSymbol:String, baseCurrSymbol:String, indexPath: Int){
        
        
        
        let baseProdObj = Array(baseCity.productData)[indexPath]
        let basePriceString = baseProdObj.value[productRange] as! String
        
        let destProdObj = Array(destCity.productData)[indexPath]
        let destPriceString = destProdObj.value[productRange] as! String
        
        if baseProdObj.key == destProdObj.key{
            productType.text = baseProdObj.key
            
            basePrice.text = "\(baseCurrSymbol) \(basePriceString)"
            destPrice.text = "\(destCurrSymbol) \(destPriceString)"
           
            
    //        if needed != nil {
    //             print(self.currentRates.doConvertion(dest: destCurr, base: baseCurr, price: needed!))
    //        } else {
    //            print("Bombed")
    //        }
            
            let calc = "\(Double(destPriceString)! - Double(basePriceString)!)"
            
            priceDifference.text = "\(baseCurrSymbol) \(calc)"
            let basePriceText = Double(basePriceString)!
            let difPrice = Double(calc)!
            
            if difPrice >= basePriceText {
                differenceLbl.text = "More Expensive"
            } else {
                differenceLbl.text = "Less Expensive"
            }
        }
    }

}
