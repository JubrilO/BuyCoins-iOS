//
//  CardSlideUpAnimator.swift
//  BuyCoins
//
//  Created by Jubril on 7/21/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit

class CardSlideUpAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var backgroundView: UIView?
    var cardView: UIView!
    var presenting = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        
        guard let originView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let destinationView = transitionContext.view(forKey: UITransitionContextViewKey.to), let backgroundView = backgroundView else {
                return
        }
        containerView.addSubview(destinationView)
        destinationView.alpha = 0

        
        let cardFrame = cardView.positionIn(view: destinationView)

        guard let originViewSnapshot = originView.snapshotView(afterScreenUpdates: true), let cardViewSnapshot = cardView.snapshotView(afterScreenUpdates: true) else {
            return
        }
        
        containerView.addSubview(backgroundView)
        containerView.addSubview(originViewSnapshot)
        containerView.addSubview(cardViewSnapshot)
        
        cardViewSnapshot.frame = cardFrame
        cardViewSnapshot.frame.origin.y = destinationView.bounds.height
        cardViewSnapshot.frame.size = CGSize(width: cardFrame.size.width * 0.8, height: cardFrame.size.height * 0.8)
        
        let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1) {
            originViewSnapshot.alpha = 0
            cardViewSnapshot.frame = cardFrame
        }
        
        animator.startAnimation()
        
        animator.addCompletion {
            _ in
            cardViewSnapshot.removeFromSuperview() 
            originViewSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            destinationView.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
