//
//  BCError.swift
//  BuyCoins
//
//  Created by Jubril on 23/05/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import SwiftyJSON

class BCError: Error {
    
    enum ErrorType: String {
        case badData = "contract_not_respected"
    }
    
    var errorType: ErrorType
    var errorMessage: String
    
    init(json: JSON) {
 
        if  json["error_type"].stringValue == ErrorType.badData.rawValue {
            self.errorType = . badData
        }
        let errorMessages = json["meta"]["error"].
    
    }
}
