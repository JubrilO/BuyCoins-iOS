//
//  SelectCurrencyCell.swift
//  BuyCoins
//
//  Created by Jubril on 7/16/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class SelectCurrencyCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyImageView: UIImageView!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
        currencyLabel.font = UIFont.bcFontMedium(size: 14)
        accessoryType = .checkmark
        }
        else {
            currencyLabel.font = UIFont.bcFontRegular(size: 14)
            accessoryType = .none

        }
    }


}
