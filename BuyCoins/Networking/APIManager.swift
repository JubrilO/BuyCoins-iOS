//
//  APIManager.swift
//  BuyCoins
//
//  Created by Jubril on 5/23/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    static let sharedManager = APIManager()
    
    func createUser(firsname: String, lastname: String, email: String, password: String, username: String, completionHandler: @escaping (User?, Error?) -> () ) {
        let parameters = [
            "first_name" : firsname,
            "last_name" : lastname,
            "email" : email,
            "password" : password
            ] as [String : Any]
        
        Alamofire.request(APIConstants.SignUpUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response  in
            switch  response.result {
            case .success(let value):
                let json = JSON(value)
                let userTuple = Utilities.saveUserFromJSON(json: json)
                completionHandler(userTuple.user, userTuple.error)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func signInUser(email: String, password: String, completionHandler: @escaping (Bool, Error?) -> ()) {
        let parameters = ["email": email, "password" : password, "recaptcha_response" : "buycoins", "signed_in_with" : "buycoins"]
        Alamofire.request(APIConstants.SignUpUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let error = Utilities.saveTokenFromJSON(json: json) {
                    completionHandler(true, StringError(error))
                }
                else {
                    completionHandler(true, nil)
                }
            case .failure(let error):
                completionHandler(true, error)
            }
        }
    }
    
}
