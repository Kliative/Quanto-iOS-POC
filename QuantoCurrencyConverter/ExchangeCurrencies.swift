//
//  ExchangeCurrencies.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/05/25.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import Foundation

class ExchangeCurrencies {
    private var _name: String!
    private var _rate: Double!
    
    var name: String {
        return _name
    }
    var rate: Double {
        return _rate
    }
    
    init(name:String, rate:Double) {
        self._name = name
        self._rate = rate
    }
    
}
