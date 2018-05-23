//
//  User.swift
//  BuyCoins
//
//  Created by Jubril on 5/23/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON


class User: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic  var email = ""
    @objc dynamic var id = ""
    @objc dynamic var phone = ""
    
    required convenience init(json: JSON) {
        self.init()
        self.firstName = json["user"]["first_name"].stringValue
        self.lastName = json["user"]["last_name"].stringValue
        self.email = json["user"]["email"].stringValue
        self.id = json["user"]["id"].stringValue
        self.phone = json["user"]["phone"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
