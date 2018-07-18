//
//  EnterAmountViewController.swift
//  BuyCoins
//
//  Created by Jubril on 7/16/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class EnterAmountViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var amountView: BCAmountTextField!
    @IBOutlet weak var headerLabel: UILabel!
    var cryptocurrency: Cryptocurrency!
    var tradeType: TradeType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onNextButtonTap(_ sender: UIButton) {
        
    }
    
    func fetchPrices() {
        let buyCoinsPriceQuery = CoinPriceQuery(cryptocurrency: cryptocurrency)
        ApolloManager.shared.apolloClient.fetch(query: buyCoinsPriceQuery) {
            result, error in
            
        }
    }
    
    
    func fetchCards() {
        let cardsQuery = CardsQuery()
        ApolloManager.shared.apolloClient.fetch(query: cardsQuery, cachePolicy: .returnCacheDataAndFetch) {
            result, error in
            
        }
    }
    
}
