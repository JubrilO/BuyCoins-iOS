//
//  TestCryptoAddress.swift
//  BuyCoins
//
//  Created by Jubril on 05/07/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
class TestCryptoAddress {
    class func address( _ ofType: Cryptocurrency) -> String {
        let testAdresses = ["39aQFZBP1eMubfZ1e7Bm1qbfEFe7uYQzMa", "0xcb99018D0C50944c715A73094555699271f2664c", "MNGeES5dAWW6oVMwS9m747stS4LEk18EbJ", "qrk33aqu7vh6zu4qlhkfg0f8k7z0wu23nqxt4gyf03"]
        switch ofType {
        case .bitcoin:
            return testAdresses[0]
        case .ethereum:
            return testAdresses[1]
        case .litecoin:
            return testAdresses[2]
        case .bitcoinCash:
            return testAdresses[3]
        default:
           return ""
        }
    }
}
