//
//  DataService.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/05/29.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import Foundation
import FirebaseDatabase

let DB_BASE = FIRDatabase.database().reference()


class DataService {

    static let ds = DataService()
    
    // DB reference
    private var _REF_BASE = DB_BASE
    private var _REF_COUNTRIES = DB_BASE.child("country_data")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_COUNTRIES: FIRDatabaseReference {
        return _REF_COUNTRIES
    }
}
