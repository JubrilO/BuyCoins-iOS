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
    
    override func awakeFromNib() {
        
    }
}
