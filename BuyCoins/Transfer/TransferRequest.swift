//
//  TransferRequest.swift
//  BuyCoins
//
//  Created by Jubril on 28/06/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation

struct TransferRequest {
    var walletAddress: String
    var amount: String
    var cryptocurrency: Cryptocurrency
    var otp: String?
    var cryptoNairaPrice: Double
    var fee: String
}
