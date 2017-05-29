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
    private var _currencyCode:String!
    private var _currencyName:String!
    private var _currencySymbol:String!
    private var _product:String!
//    private var _products:Dictionary<String, String>!
    

    
    private var _coke:Dictionary<String, AnyObject>!
    private var _domBeer:Dictionary<String, AnyObject>!
    private var _impBeer:Dictionary<String, AnyObject>!
    private var _mcMeal:Dictionary<String, AnyObject>!
    private var _meal:Dictionary<String, AnyObject>!
    private var _movieTicket:Dictionary<String, AnyObject>!
    private var _oneWayTicket:Dictionary<String, AnyObject>!
    
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
    var product:String{
        return _product
    }
    
    var coke:Dictionary<String, AnyObject>{
        return _coke
    }
    var domBeer:Dictionary<String, AnyObject>{
        return _domBeer
    }
    var impBeer:Dictionary<String, AnyObject>{
        return _impBeer
    }
    var mcMeal:Dictionary<String, AnyObject>{
        return _mcMeal
    }
    var meal:Dictionary<String, AnyObject>{
        return _meal
    }
    var movieTicket:Dictionary<String, AnyObject>{
        return _movieTicket
    }
    var oneWayTicket:Dictionary<String, AnyObject>{
        return _oneWayTicket
    }
    
    init(countryName:String, currencyCode: String, currencyName: String, currencySymbol: String, productData:Dictionary<String, AnyObject>) {
        
        self._countryName = countryName
        self._currencyCode = currencyCode
        self._currencyName = currencyName
        self._currencySymbol = currencySymbol
        
        if let coke = productData["Coke"] as? Dictionary<String, AnyObject>{
           self._coke = coke
        }
        
        if let domBeer = productData["DomBeer"] as? Dictionary<String, AnyObject>{
            self._domBeer = domBeer
        }
        
        if let impBeer = productData["ImpBeer"] as? Dictionary<String, AnyObject>{
            self._impBeer = impBeer
        }
        
        if let mcMeal = productData["McMeal"] as? Dictionary<String, AnyObject>{
            self._mcMeal = mcMeal
        }
        
        if let meal = productData["Meal"] as? Dictionary<String, AnyObject>{
            self._meal = meal
        }
        
        if let movieTicket = productData["MovieTicket"] as? Dictionary<String, AnyObject>{
            self._movieTicket = movieTicket
        }
        
        if let oneWayTicket = productData["OneWayTicket"] as? Dictionary<String, AnyObject>{
            self._oneWayTicket = oneWayTicket
        }
        
    }
}
