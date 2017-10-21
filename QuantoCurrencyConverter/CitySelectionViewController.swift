//
//  CitySelectionViewController.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/10/18.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

protocol selectedCityDelegate {
    func loadSelectedCity(baseCitySel:String,destCitySel:String)
    
}

class CitySelectionViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var delegate: selectedCityDelegate? = nil
    

    @IBOutlet weak var baseCityTableView:UITableView!
    @IBOutlet weak var destCityTableView:UITableView!
    
    
    @IBOutlet weak var baseCityLbl: UILabel!
    @IBOutlet weak var destCityLbl: UILabel!
    var baseCities:[String] = []
    var destCities:[String] = []
    
    var cityIndexRow: Int!
    var productList:Int!

    var isBaseFull = false
    var isDestFull = false
    
    var baseCitySelected:String!
    var destCitySelected:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseCityTableView.delegate = self
        self.baseCityTableView.dataSource = self
        
        self.destCityTableView.delegate = self
        self.destCityTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch tableView {
        case baseCityTableView :
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCityCell", for:indexPath) as? CitiesCell{
                cell.configureCityCell(cityName: self.baseCities[indexPath.row])
                if(cell.isSelected){
                    cell.backgroundColor = UIColor.red
                }else{
                    cell.backgroundColor = UIColor.clear
                }
                return cell
                
            } else {
                return CitiesCell()
            }
        case destCityTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DestCityCell", for:indexPath) as? CitiesCell{
                cell.configureCityCell(cityName: self.destCities[indexPath.row])
                if(cell.isSelected){
                    cell.backgroundColor = UIColor.red
                }else{
                    cell.backgroundColor = UIColor.clear
                }
                return cell
                
            } else {
                return CitiesCell()
            }
        default:
            return UITableViewCell()
        }
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView
        {
        case baseCityTableView:
            return self.baseCities.count
            
        case destCityTableView:
            return self.destCities.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red:74/255, green:74/255, blue:74/255,alpha:1)
        
        self.cityIndexRow = indexPath.row
        
        switch tableView
        {
        case baseCityTableView:

            FIRAnalytics.logEvent(withName: "Base_City_Sel", parameters: ["City":self.baseCities[self.cityIndexRow]])
            self.baseCityLbl.text = self.baseCities[self.cityIndexRow]
            self.baseCitySelected = self.baseCities[self.cityIndexRow]
            print(self.baseCitySelected)
        case destCityTableView:

            FIRAnalytics.logEvent(withName: "Dest_City_Sel", parameters: ["City":self.destCities[self.cityIndexRow]])
            self.destCitySelected = self.destCities[self.cityIndexRow]
            self.destCityLbl.text = self.destCities[self.cityIndexRow]
            print(self.destCitySelected)
           
        default:
            break
        }
    }

    
    @IBAction func dismissVC(_ sender: Any) {
        
        if delegate != nil {
            delegate?.loadSelectedCity(baseCitySel: "London", destCitySel: self.destCitySelected)
            dismiss(animated: true, completion: nil)
        }
        
    }
    

}
