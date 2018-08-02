//
//  ReviewSendViewController.swift
//  BuyCoins
//
//  Created by Jubril on 28/06/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit

class ReviewSendViewController: UIViewController, CardView {
    
    @IBOutlet weak var totalNairaAmountLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var totalCryptoAmountLabel: UILabel!
    @IBOutlet weak var transferFeeNairaLabel: UILabel!
    @IBOutlet weak var transferFeeCryptoLabel: UILabel!
    @IBOutlet weak var recieversWalletAddressLabel: UILabel!
    @IBOutlet weak var nairaPricePerBTCLabel: UILabel!
    @IBOutlet weak var cryptoTypeLabel: UILabel!
    @IBOutlet weak var cryptoAmountLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    var transferRequest: TransferRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    func setupLabels() {
        cryptoAmountLabel.text = transferRequest.amount
        recieversWalletAddressLabel.text = transferRequest.walletAddress
        cryptoTypeLabel.text = String.cryptocurrency(transferRequest.cryptocurrency)
        nairaPricePerBTCLabel.text = "NGN " + transferRequest.cryptoNairaPrice.withCommas() + " / \(String.cryptocurrency(transferRequest.cryptocurrency))"
        transferFeeCryptoLabel.text = String(Double(transferRequest.fee)!) + " " + String.cryptocurrency(transferRequest.cryptocurrency)
        transferFeeNairaLabel.text = String((Double(transferRequest.fee)! * transferRequest.cryptoNairaPrice).withCommas()) + " NGN"
        let totalCryptoAmount = Double(transferRequest.fee)! + Double(transferRequest.amount)!
        totalCryptoAmountLabel.text = String(totalCryptoAmount)
        totalNairaAmountLabel.text = String((totalCryptoAmount * transferRequest.cryptoNairaPrice).withCommas()) + " NGN"
        sendButton.setTitle("Send \(transferRequest.amount) \(String.cryptocurrency(transferRequest.cryptocurrency))", for: .normal)
    }
    
    @IBAction func onBackButtonTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onSendButtonTap(_ sender: UIButton) {
        let loadingVC = LoadingViewController()
        add(loadingVC)
        getOTPStatus {
            sendOtp, error in
            guard error == nil else {
                loadingVC.remove()
                self.displayErrorModal(error: error)
                return
            }
            
            if sendOtp {
                self.sendOTP {
                    sent in
                    loadingVC.remove()
                    sent ? self.presentOTPScene() : self.displayErrorModal(error: "Could not send OTP")
                }
            }
            else {
                self.sendCoin {
                    loadingVC.remove()
                }
            }
        }
    }
    
    func presentOTPScene() {
        if let otpVC =  storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIDs.OTPScene) as? OTPViewController {
            otpVC.transitioningDelegate = self
            present(otpVC, animated: true, completion: nil)
        }
    }
    
    func sendCoin(completion: @escaping () ->() ) {
        let sendCoinMutation = SendCoinMutation(amount: transferRequest.amount, cryptocurrency: transferRequest.cryptocurrency, address: transferRequest.walletAddress, otp: transferRequest.otp)
        
        ApolloManager.shared.apolloClient.perform(mutation: sendCoinMutation) {
            result, error in
            completion()
            guard let sendCoinsAction =  result?.data?.sendCoins else {
                self.displayErrorModal(error: error?.localizedDescription)
                return
            }
            if sendCoinsAction.initiated {
                print("Dismiss Send Coin Modal")
            }
            else {
                print("Send action not initiated!")
            }
        }
    }
    
    func getOTPStatus(completion: @escaping (Bool, String?) -> ()) {
        let otpStatusQuery = OtpStatusQuery()
        ApolloManager.shared.apolloClient.fetch(query: otpStatusQuery) {
            result, error in
            guard let currentUser = result?.data?.currentUser else {
                self.displayErrorModal(error: error?.localizedDescription)
                completion(false, error?.localizedDescription)
                return
            }
            if currentUser.twoFactorAuthentication! && currentUser.twoFactorType! == .sms {
                completion(true, nil)
            }
            else {
                completion(false, nil)
            }
            
        }
    }
    
    func sendOTP(completion: @escaping (Bool) -> () ) {
        let sentOTPMutation = SendOtpMutation(call: true)
        ApolloManager.shared.apolloClient.perform(mutation: sentOTPMutation) {
            result, error in
            guard let _ =  result?.data?.sendOtp?.username else {
                self.displayErrorModal(error: error?.localizedDescription)
                completion(false)
                return
            }
            completion(true)
        }
    }
}

extension ReviewSendViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let dismissedVC = dismissed as? ReviewSendViewController {
            let cardDismissalAnimator = CardDismissalAnimator()
            cardDismissalAnimator.originCardView = dismissedVC.cardView
            cardDismissalAnimator.destinationCardView = cardView
            let backgroundView = BackgroundView()
            backgroundView.frame = view.frame
            cardDismissalAnimator.backgroundView = backgroundView
            return cardDismissalAnimator
        }
        return nil
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let destinationVC = presented as? OTPViewController {
            let slideAnimator = CardPresentationAnimator()
            let backgroundView = BackgroundView()
            backgroundView.frame = view.frame
            slideAnimator.originCardView = cardView
            slideAnimator.destinationCardView = destinationVC.cardView
            return slideAnimator
        }
            return nil
    }
}
