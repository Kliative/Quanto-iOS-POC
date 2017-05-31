//
//  CitiesCell.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/05/31.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import UIKit

class CitiesCell: UITableViewCell {
    @IBOutlet weak var cityNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCityCell(cityName:String){
        self.cityNameLbl.text = cityName
    }

}
