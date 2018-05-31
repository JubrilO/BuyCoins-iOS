//
//  APIConstants.swift
//  BuyCoins
//
//  Created by Jubril on 5/23/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation

struct APIConstants {
    static let BaseUrl = "https://bitkoin-dev.herokuapp.com/api/v1"
    static let GraphqlUrl = "https://bitkoin-dev.herokuapp.com/graphql"
    static let AuthUrl = BaseUrl + "/tokens?buycoins=true"
    static let SignUpUrl = BaseUrl + "/users"
}
