//
//  CardSlideDownAnimator.swift
//  BuyCoins
//
//  Created by Jubril on 7/21/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit

class CardSlideDownAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var cardView: UIView!
    var destinationSnapshot: UIView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        
        guard let originView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let destinationView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                return
        }
        containerView.addSubview(destinationView)
        destinationView.alpha = 0
        
        let backgroundView = BackgroundView()
        backgroundView.frame = destinationView.frame
        
        
        let cardFrame = cardView.positionIn(view: destinationView)
        
        guard let destinationViewSnapshot = destinationSnapshot, let cardViewSnapshot = cardView.snapshotView(afterScreenUpdates: true) else {
            return
        }
        
        containerView.addSubview(backgroundView)
        containerView.addSubview(destinationViewSnapshot)
        containerView.addSubview(cardViewSnapshot)
        
        cardViewSnapshot.frame = cardFrame
        destinationViewSnapshot.alpha = 0
        
        
        let animator = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.8) {
            destinationViewSnapshot.alpha = 1
            cardViewSnapshot.frame.origin.y = destinationView.bounds.height
            cardViewSnapshot.frame.size = CGSize(width: cardFrame.size.width * 0.8, height: cardFrame.size.height * 0.8)
        }
        
        animator.startAnimation()
        
        animator.addCompletion {
            _ in
            destinationViewSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            cardViewSnapshot.removeFromSuperview()
            destinationView.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
