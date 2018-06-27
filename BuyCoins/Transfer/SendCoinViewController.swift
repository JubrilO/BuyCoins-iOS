//
//  SendCoinViewController.swift
//  BuyCoins
//
//  Created by Jubril on 6/25/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import SwiftValidator

class SendCoinViewController: UIViewController {
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var availableBalanceLabel: UILabel!
    @IBOutlet weak var amountTextField: BCBorderedTextField!
    @IBOutlet weak var walletAddressTextField: BCBorderedTextField!
    @IBOutlet weak var headerLabel: UILabel!
    
    let validator = Validator()
    
    var cryptocurrency = Cryptocurrency.bitcoin
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSendButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func onMaxAmountButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func onCloseButtonTap(_ sender: UIButton) {
        
    }
    
    @IBAction func onScanButtonTouch(_ sender: UIButton) {
        
    }
    
    func setupTextFieldValidation() {
        
    }
    
    func sendCoin(amount: Float, address: String) {
        let sendCoinMutation = SendCoinMutation(amount: <#T##String?#>, cryptocurrency: <#T##Cryptocurrency?#>, address: <#T##String#>, otp: <#T##String?#>)
    }
    
}
