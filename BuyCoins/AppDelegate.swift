//
//  AppDelegate.swift
//  BuyCoins
//
//  Created by Jubril on 22/05/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import Apollo
import IQKeyboardManagerSwift
import Locksmith

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let apollo = ApolloClient(url: URL(string: APIConstants.GraphqlUrl)!)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        let launchCount = UserDefaults.standard.integer(forKey: "launchCount")
        if launchCount == 0{
            let _ = try? Locksmith.deleteDataForUserAccount(userAccount: Constants.BCUser)
        }
        UserDefaults.standard.set(launchCount+1, forKey:"launchCount")
        UserDefaults.standard.synchronize()
        
        if let _ = Locksmith.loadDataForUserAccount(userAccount: Constants.BCUser)?["token"] as? String {
            let landingStoryboard = UIStoryboard(name: Constants.StoryboardNames.Landing, bundle: nil)
            let initialVC = landingStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIDs.LandingTabBar)
            window?.rootViewController = initialVC
            window?.makeKeyAndVisible()
        }
        else {
           let authStoryboard = UIStoryboard(name: Constants.StoryboardNames.Auth, bundle: nil)
            let signInVC = authStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIDs.SignInScene)
            window?.rootViewController = signInVC
            window?.makeKeyAndVisible()
        }
        return true
    }
}

