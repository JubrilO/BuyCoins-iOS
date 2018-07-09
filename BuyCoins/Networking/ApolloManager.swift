//
//  GraphQL.swift
//  BuyCoins
//
//  Created by Jubril on 28/06/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import Apollo
import Locksmith

class ApolloManager {
   
    static let shared = ApolloManager()
    let apolloClient: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        let url = URL(string: APIConstants.GraphqlUrl)!
        if let auth = Locksmith.loadDataForUserAccount(userAccount: Constants.BCUser)?["token"] as? String {
            configuration.httpAdditionalHeaders = ["Authorization": auth]
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        }
        else {
            print("Sign in user")
            return ApolloClient(url: url)
        }
    }()
}
