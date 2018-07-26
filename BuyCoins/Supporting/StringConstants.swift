//
//  StringConstants.swift
//  BuyCoins
//
//  Created by Jubril on 5/23/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation

struct Constants {
    static let BCUser = "BCUser"
    
    struct StoryboardIDs {
        static let LandingTabBar = "LandingTabBar"
        static let SignInScene = "SignInScene"
        static let SignUpScene = "SignUpScene"
        static let SendCoinScene = "SendCoinScene"
        static let ReviewSendScene = "ReviewSendScene"
        static let WalletAddressScene = "WalletAddressScene"
        static let SelectCurrencyScene = "SelectCurrencyScene"
        static let EnterAmountScene = "EnterAmountScene"
        static let CreateAccountScene = "CreateAccountScene"
    }
    
    struct StoryboardNames {
        static let Landing = "Landing"
        static let Auth = "Auth"
        static let Transfer = "Transfer"
        static let Trade = "Trade"
    }
    
    struct CellIdentifiers {
        static let WalletPagerCell = "WalletPagerCell"
        static let WalletTransactionCell = "WalletTransactionCell"
        static let SelectCurrencyCell = "SelectCurrencyCell"
    }
}
