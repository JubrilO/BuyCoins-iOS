//
//  SelectCurrencyViewController.swift
//  BuyCoins
//
//  Created by Jubril on 7/16/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class SelectCurrencyViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var selectedCurrency: Cryptocurrency?
    var tradeType = TradeType.sell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        switch tradeType {
        case .buy:
            headerLabel.text = "Buy Coins"
        case .sell:
            headerLabel.text = "Sell Coins"
        }
    }
    
    @IBAction func onNextButtonTap(_ sender: UIButton) {
        if let cryptocurrency =  selectedCurrency {
            
        }
    }

}

extension SelectCurrencyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.SelectCurrencyCell) as! SelectCurrencyCell
        switch indexPath.row {
        case 0:
            cell.currencyImageView.image = #imageLiteral(resourceName: "Bitcoin_logo")
            cell.currencyLabel.text = "Bitcoin"
        case 1:
            cell.currencyImageView.image = #imageLiteral(resourceName: "ethreum_logo")
            cell.currencyLabel.text = "Ethereum"
        case 2:
            cell.currencyImageView.image = #imageLiteral(resourceName: "litecoin")
            cell.currencyLabel.text = "Litecoin"
        case 3:
            cell.currencyImageView.image = #imageLiteral(resourceName: "bitcoin_cash")
            cell.currencyLabel.text = "Bitcoin Cash"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextButton.isEnabled = true
        switch indexPath.row {
        case 0:
            selectedCurrency = .bitcoin
        case 1:
            selectedCurrency = .ethereum
        case 2:
            selectedCurrency = .litecoin
        case 3:
            selectedCurrency = .bitcoinCash
        default:
            break
        }
    }
}

enum TradeType {
    case buy
    case sell
}
