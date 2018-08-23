//
//  TabBarSlideAnimator.swift
//  BuyCoins
//
//  Created by Jubril on 11/08/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit

class TransitioningObject: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView: UIView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView: UIView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        transitionContext.containerView.addSubview(fromView)
        transitionContext.containerView.addSubview(toView)
        
        UIView.transition(from: fromView, to: toView, duration: transitionDuration(using: transitionContext), options: UIViewAnimationOptions.transitionCrossDissolve) { finished in
            transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
}
