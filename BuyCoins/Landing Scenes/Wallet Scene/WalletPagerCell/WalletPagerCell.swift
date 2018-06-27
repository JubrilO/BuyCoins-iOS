//
//  WalletPagerCell.swift
//  BuyCoins
//
//  Created by Jubril on 6/13/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import FSPagerView

class WalletPagerCell: FSPagerViewCell {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var walletTypeLabel: UILabel!
    @IBOutlet weak var cryptoBalanceLabel: UILabel!
    @IBOutlet weak var nairaBalanceLabel: UILabel!
    @IBOutlet weak var cryptoCurrencyLabel: UILabel!
    
    func loadData(_ walletData: WalletTransactionsQuery.Data) {
        let wallet = walletData.currentUser!.wallet!
        switch wallet.cryptocurrency! {
        case .bitcoin:
            walletTypeLabel.text = "BTC Wallet"
            cryptoCurrencyLabel.text = "BTC"
        case .ethereum:
            walletTypeLabel.text = "ETH Wallet"
            cryptoCurrencyLabel.text = "ETH"
        case .litecoin:
            walletTypeLabel.text = "LTC Wallet"
            cryptoCurrencyLabel.text = "LTC"
        case .bitcoinCash:
            walletTypeLabel.text = "BCH Wallet"
            cryptoCurrencyLabel.text = "BCH"
        default:
            break
        }
        cryptoBalanceLabel.text = wallet.confirmedBalance
        nairaBalanceLabel.text = String((Double(walletData.cryptoPriceIndex!.values!.first!!.rate!)! * Double(wallet.confirmedBalance!)!).withCommas() + " NGN")
    }
}
