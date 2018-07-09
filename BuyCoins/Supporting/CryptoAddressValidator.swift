//
//  CryptoAddressValidator.swift
//  BuyCoins
//
//  Created by Jubril on 05/07/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
class CryptoAddressValidator {
    let cryptoRegex: [String : String] = [
        Cryptocurrency.bitcoin.rawValue: "[13][a-km-zA-HJ-NP-Z1-9]{25,34}",
        Cryptocurrency.bitcoinCash.rawValue: "[13][a-km-zA-HJ-NP-Z1-9]{33}",
        Cryptocurrency.ethereum.rawValue: "0x[a-fA-F0-9]{40}",
        Cryptocurrency.litecoin.rawValue: "[LM3][a-km-zA-HJ-NP-Z1-9]{26,33}"
    ]
    var address: String
    var cryptocurrency: Cryptocurrency
    
    init(_ address: String, crypto: Cryptocurrency) {
        self.address = address
        self.cryptocurrency = crypto
    }
    
    func getAddress() -> String? {
        return match(for: cryptoRegex[cryptocurrency.rawValue], in: address)
    }
    
    private func match(for regex: String?, in text: String) -> String? {
        if let regex = regex {
            
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let results = regex.matches(in: text,
                                            range: NSRange(text.startIndex..., in: text))
                return results.map {
                    String(text[Range($0.range, in: text)!])
                    }.first
            } catch let error {
                print("invalid regex: \(error.localizedDescription)")
                return nil
            }
        }
        else {
            return nil
        }
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

