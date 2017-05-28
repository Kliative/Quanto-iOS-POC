//
//  baseCurrVC.swift
//  QuantoCurrencyConverter
//
//  Created by Tawanda Kanyangarara on 2017/05/24.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import UIKit


protocol baseDataSentDelegate {
    func userDidEnterBaseData(data: String)
}

class baseCurrVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    
    
    var filterData = [String]()
    
    
    var sortedCurrency:[String] = []
    
    var currentRates: CurrentExchange!
     var delegate: baseDataSentDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        currentRates = CurrentExchange()
        
        currentRates.downloadExchangeRates {
            
           //Arranges Array in Alphabetical Order
            self.sortedCurrency = self.currentRates.sortedCurrency
            
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
            let text: String!
        
            if let cell = tableView.dequeueReusableCell(withIdentifier: "baseCurrCell", for:indexPath) as? CurrencyCell{
                
                if isSearching {
                    text = filterData[indexPath.row]
                } else {
                    text = self.sortedCurrency[indexPath.row]
                }
                
                cell.configureCurrencyCell(currencyName: text)
                
                return cell
                
            } else {
                return CurrencyCell()
            }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filterData.count
        }
        
        return self.currentRates.myCurrency.count
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearching {
            let data = filterData[indexPath.row]
            delegate?.userDidEnterBaseData(data: data)
        } else {
            let data = self.sortedCurrency[indexPath.row]
            delegate?.userDidEnterBaseData(data: data)
        }
        
        dismiss(animated: true) {
            ViewController().reCalc()
        }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else{
            isSearching = true
            
            let lower = searchBar.text!.uppercased()
            filterData = self.sortedCurrency.filter({$0.range(of: lower) != nil})
            tableView.reloadData()
        }
        
    }
    
    @IBAction func dismissBaseVCPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
