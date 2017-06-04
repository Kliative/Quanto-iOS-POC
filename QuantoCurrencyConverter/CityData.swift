//
//  CityData.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/05/30.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import Foundation

class CityData {
    
    private var _countryName:String!
    private var _cityName:String!
    private var _coke:Dictionary<String, AnyObject>!
    private var _domBeer:Dictionary<String, AnyObject>!
    private var _impBeer:Dictionary<String, AnyObject>!
    private var _mcMeal:Dictionary<String, AnyObject>!
    private var _meal:Dictionary<String, AnyObject>!
    private var _movieTicket:Dictionary<String, AnyObject>!
    private var _oneWayTicket:Dictionary<String, AnyObject>!
    
    private var _packSmokes:Dictionary<String, AnyObject>!
    private var _waterBottle:Dictionary<String, AnyObject>!
    private var _wineBottle:Dictionary<String, AnyObject>!
    
    private var _productData:Dictionary<String, AnyObject>!
    
    var countryName:String{
        return _countryName
    }
    var cityName:String{
        return _cityName
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
    var packSmokes:Dictionary<String, AnyObject>{
        return _packSmokes
    }
    var waterBottle:Dictionary<String, AnyObject>{
     return _waterBottle
    }
    var wineBottle:Dictionary<String, AnyObject>{
        return _wineBottle
    }
    
    var productData:Dictionary<String, AnyObject>{
        return _productData
    }
    
    init(cityName:String, productData:Dictionary<String, AnyObject>){
        
        self._cityName = cityName
        
        
        self._productData = productData
        
//        for (key, value) in productData {
//            print(key)
//            print(value)
//        }
//        
        
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
        
        if let packSmokes = productData["PackSmokes"] as? Dictionary<String, AnyObject>{
            self._packSmokes = packSmokes
        }
        
        if let waterBottle = productData["WaterBottle"] as? Dictionary<String, AnyObject>{
            self._waterBottle = waterBottle
        }
        
        if let wineBottle = productData["WineBottle"] as? Dictionary<String, AnyObject>{
            self._wineBottle = wineBottle
        }

    }
}
