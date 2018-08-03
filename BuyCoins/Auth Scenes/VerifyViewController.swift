//
//  VerifyViewController.swift
//  BuyCoins
//
//  Created by Jubril on 23/05/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var cardView: UIView!
    var backgroundView: UIView?
    let slideAnimator = CardPresentationAnimator()

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cardView.isHidden = true
        backgroundView = view.resizableSnapshotView(from: view.bounds, afterScreenUpdates: true, withCapInsets: .zero)
        cardView.isHidden = false

    }

    @IBAction func onResendEmailButton(_ sender: UIButton) {
        print("resending verification email")
    }
    
    @IBAction func onSignInButtonTap(_ sender: UIButton) {
        if let signInVC = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIDs.SignInScene) as? SignInViewController {
            signInVC.transitioningDelegate = self
            present(signInVC, animated: true)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let vc = presented as? SignInViewController {
            slideAnimator.backgroundView = backgroundView
            slideAnimator.originCardView = cardView
            slideAnimator.destinationCardView = vc.cardView
            return slideAnimator
        }
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}
