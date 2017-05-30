//
//  ProductData.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/05/30.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import Foundation

class ProductData {

    private var _productName:String!
    private var _high:String!
    private var _norm:String!
    private var _low:String!
    
    var productName:String{
        return _productName
    }
    
    var high:String{
        return _high
    }
    
    var norm:String{
        return _norm
    }
    
    var low:String{
        return _low
    }
    
    init(productName:String, productData:Dictionary<String, AnyObject>) {
        
        self._productName = productName
        
        if let high = productData["high"] as? String{
            self._high = high
        }
        if let norm = productData["norm"] as? String{
            self._norm = norm
        }
        if let low = productData["low"] as? String{
            self._low = low
        }
        
    }
    
}

