//
//  CardDismissalAnimator.swift
//  BuyCoins
//
//  Created by Jubril on 7/20/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import Foundation
import UIKit

class CardDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var backgroundView: UIView?
    var originCardView: UIView!
    var destinationCardView: UIView!
    
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
        
        guard let originCardViewSnapshot = originCardView.snapshotView(afterScreenUpdates: true), let destinationCardViewSnapshot = destinationCardView.snapshotView(afterScreenUpdates: false) else {
            return
        }
        
        let originCardFrame = originCardView.positionIn(view: originView)
        let destinationCardFrame = destinationCardView.positionIn(view: destinationView)
        
        originCardViewSnapshot.frame = originCardFrame
        destinationCardViewSnapshot.frame = destinationCardFrame
        destinationCardViewSnapshot.frame.origin.x -= (destinationCardFrame.width  + destinationCardFrame.origin.x)
        
        containerView.addSubview(backgroundView)
        containerView.addSubview(originCardViewSnapshot)
        containerView.addSubview(destinationCardViewSnapshot)
        
        destinationCardViewSnapshot.frame.size = CGSize(width: destinationCardFrame.width * 0.7, height: destinationCardFrame.height * 0.7)
        
        
        let animator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.7) {
            originCardViewSnapshot.frame.origin.x = originView.frame.width + originCardFrame.width
            originCardViewSnapshot.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
        
        let destinationCardAnimator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.7) {
            destinationCardViewSnapshot.frame.origin.x = destinationCardFrame.origin.x
            destinationCardViewSnapshot.frame.size = CGSize(width: destinationCardFrame.size.width, height: destinationCardFrame.size.height)
        }
        animator.startAnimation()
        destinationCardAnimator.startAnimation(afterDelay: 0.3)
        
        destinationCardAnimator.addCompletion {
            _ in
            destinationCardViewSnapshot.removeFromSuperview()
            originCardViewSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            destinationView.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
