//
//  File.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/05/29.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import Foundation


class CountryData {
    private var _countryName:String!
    private var _capitalName:String!
    private var _currencyCode:String!
    private var _currencyName:String!
    private var _currencySymbol:String!
    
    private var _cities:[String] = []
    
    
    
    var capitalName:String{
        return _capitalName
    }
    var countryName:String{
        return _countryName
    }
    var currencyCode:String{
        return _currencyCode
    }
    var currencyName:String{
        return _currencyName
    }
    var currencySymbol:String{
        return _currencySymbol
    }

    
    
    var cities:[String]{
        return _cities
    }
    
    init(countryName:String, currencyCode: String, currencyName: String, currencySymbol: String,capitalName:String, cities:[String]) {
        
        self._countryName = countryName
        self._currencyCode = currencyCode
        self._currencyName = currencyName
        self._currencySymbol = currencySymbol
        
        self._cities = cities
        
        self._capitalName = capitalName
        
        
    }
}
