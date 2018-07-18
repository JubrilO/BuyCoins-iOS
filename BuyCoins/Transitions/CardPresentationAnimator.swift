//
//  CardPresentationAnimator.swift
//  BuyCoins
//
//  Created by Jubril on 7/18/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit

class CardPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)
    }
}
