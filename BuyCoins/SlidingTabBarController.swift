//
//  SlidingTabBarController.swift
//  BuyCoins
//
//  Created by Jubril on 11/08/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class SlidingTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitioningObject()
    }
}
