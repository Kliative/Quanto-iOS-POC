//
//  Constants.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/05/16.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import Foundation


let LASTEST_RATES = "https://openexchangerates.org/api/latest.json?app_id=8189c190e69d471fb0b4abfba0a7c023"


//Need to upgrade account for these features
let BASE_URL = "https://openexchangerates.org/api/convert/"
let PRICE = "1000"
let BASE_CURRENCY = "ZAR"
let DEST_CURRENCY = "EUR"
let APP_ID_KEY = "?app_id=8189c190e69d471fb0b4abfba0a7c023"

let CALC_URL = "\(BASE_URL)\(PRICE)/\(DEST_CURRENCY)/\(BASE_CURRENCY)\(APP_ID_KEY)"


typealias DownloadComplete = () -> ()

