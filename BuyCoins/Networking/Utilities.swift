//
//  Utilities.swift
//  BuyCoins
//
//  Created by Jubril on 5/23/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Locksmith
import RealmSwift

class Utilities {
    
    class func saveTokenFromJSON(json: JSON) {
        if let token =  json["token"].string {
            let tokenDict = ["token" : token]
            try! Locksmith.saveData(data: tokenDict, forUserAccount: Constants.BCUser)
        }
        else {
            
        }
    }
    
    class func saveUserFromJSON(json: JSON) -> (user: User?, error: Error?) {
        if let token =  json["token"].string{
            let user = User(json: json)
            try! Realm().add(user)
            saveTokenToLocksmith(token: token)
            return (user, nil)
        }
        else {
            return (nil, StringError(""))
        }
    }
    
    private class func saveTokenToLocksmith(token: String) {
        let tokenDict = ["token" : token]
        try! Locksmith.saveData(data: tokenDict, forUserAccount: Constants.BCUser)
    }
    
    private class func parseErrorFromJSON(json: JSON) {
        //let
        
    }
}

struct StringError : LocalizedError {
    var errorDescription: String? { return mMsg }
    var failureReason: String? { return mMsg }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }
    
    private var mMsg : String
    
    init(_ description: String)
    {
        mMsg = description
    }
}
