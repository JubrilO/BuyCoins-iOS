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
        let sendCoinMutation = SendCoinMutation(amount: transferRequest.amount, cryptocurrency: transferRequest.cryptocurrency, address: transferRequest.walletAddress, otp: transferRequest.otp)
        ApolloManager.shared.apolloClient.perform(mutation: sendCoinMutation) {
            result, error in
            guard let sendCoinsAction =  result?.data?.sendCoins else {
                self.displayErrorModal(error: error?.localizedDescription)
                return
            }
            if sendCoinsAction.initiated {
                print("Dismiss Send Coin Modal")
                self.dismiss(animated: true)
            }
            else {
                print("Send action not initiated!")
            }
            
        }
    }
    
    
}
