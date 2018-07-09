//
//  SendCoinViewController.swift
//  BuyCoins
//
//  Created by Jubril on 6/25/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import SwiftValidator
import Apollo
import QRCodeReader

class SendCoinViewController: UIViewController, ValidationDelegate, QRCodeReaderViewControllerDelegate {
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var availableBalanceLabel: UILabel!
    @IBOutlet weak var amountTextField: BCBorderedTextField!
    @IBOutlet weak var walletAddressTextField: BCBorderedTextField!
    @IBOutlet weak var headerLabel: UILabel!
    
    let validator = Validator()
    
    private var walletData: WalletBalanceQuery.Data? {
        didSet {
            fetchNetworkMaxNetworkFee()
            setupLabels()
        }
    }
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    var cryptocurrency = Cryptocurrency.bitcoin
    var cryptoNairaPrice: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        fetchAvailableBalance()
        setupTextFieldValidation()
    }
    
    @IBAction func onSendButtonTap(_ sender: UIButton) {
        validator.validate(self)
    }
    
    @IBAction func onMaxAmountButtonTap(_ sender: UIButton) {
        guard let walletData = walletData else {return}
        guard let availableBalance =  Double(walletData.currentUser!.wallet!.confirmedBalance!) else {return}
        //TO-DO add condition that accomodates for transaction fees
        
        
        if availableBalance > 0.0 {
            amountTextField.text = String(availableBalance)
        }
    }
    
    @IBAction func onCloseButtonTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onScanButtonTouch(_ sender: UIButton) {
        readerVC.delegate = self
        present(readerVC, animated: true)
    }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        if let address = CryptoAddressValidator.init(result.value, crypto: cryptocurrency).getAddress() {
            reader.stopScanning()

            reader.dismiss(animated: true)
            walletAddressTextField.text = address
        }
        else {
            reader.displayErrorModal(error: "Invalid \(cryptocurrency.rawValue.capitalized) address") {
                _ in
                reader.startScanning()
            }
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        reader.dismiss(animated: true)
    }
    
    func validationSuccessful() {
        guard let walletData = walletData else {return}
        if CryptoAddressValidator.init(walletAddressTextField.text!, crypto: cryptocurrency).getAddress() == nil { return }
        if Float(amountTextField.text!)! <= Float(walletData.currentUser!.wallet!.confirmedBalance!)! {
            presentConfirmation()
        }
        else {
            displayErrorModal(error: "Insufficent funds")
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (textfield, _) in errors {
            if let txt = textfield as? UITextField {
                txt.layer.borderColor = UIColor.red.cgColor
                txt.layer.borderWidth = 1
            }
        }
    }
    
    func setupLabels() {
        currencyLabel.setCryptoCurrency(cryptoCurrency: cryptocurrency)
        amountTextField.placeholder = "0.00 " + String.cryptocurrency(cryptocurrency)
    }
    
    func setupTextFieldValidation() {
        validator.registerField(walletAddressTextField, rules: [RequiredRule()])
        validator.registerField(amountTextField, rules: [RequiredRule(), FloatRule()])
    }
    
    func presentConfirmation() {
        let address = walletAddressTextField.text!
        let amount = amountTextField.text!
        let networkFeeQuery = NetworkFeeQuery(amount: amount, address: TestCryptoAddress.address(cryptocurrency), cryptocurrency: cryptocurrency)
        ApolloManager.shared.apolloClient.fetch(query: networkFeeQuery, cachePolicy: .returnCacheDataAndFetch) {
            result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            guard let fee = result?.data?.getEstimatedNetworkFee?.estimatedFee else {return}
            let transferRequest = TransferRequest(walletAddress: address, amount: amount, cryptocurrency: self.cryptocurrency, otp: nil, cryptoNairaPrice: self.cryptoNairaPrice, fee: fee)
            if let confirmationVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIDs.ReviewSendScene) as? ReviewSendViewController {
                confirmationVC.transferRequest = transferRequest
                self.present(confirmationVC, animated: true)
                //navigationController?.pushViewController(confirmationVC, animated: true)
            }
        }
        
    }
    func fetchNetworkMaxNetworkFee() {
        guard let confirmedBalance = walletData?.currentUser?.wallet?.confirmedBalance else {return}
        let networkFeeQuery = NetworkFeeQuery(amount: confirmedBalance, address: TestCryptoAddress.address(cryptocurrency), cryptocurrency: cryptocurrency)
        ApolloManager.shared.apolloClient.fetch(query: networkFeeQuery, cachePolicy: .returnCacheDataAndFetch) {
            result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            guard let fee = result?.data?.getEstimatedNetworkFee?.estimatedFee else {return}
           let availableBalance = Double(confirmedBalance)! - Double(fee)!
            self.availableBalanceLabel.text = String(availableBalance)
        }
    }
    
    func fetchAvailableBalance() {
        let walletBalanceQuery = WalletBalanceQuery(cryptocurrency: cryptocurrency)
        ApolloManager.shared.apolloClient.fetch(query: walletBalanceQuery, cachePolicy: .returnCacheDataAndFetch) {
            result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            self.walletData = result?.data
        }
    }
    
}

extension UILabel {
    func setCryptoCurrency(cryptoCurrency: Cryptocurrency) {
        var cryptoString = ""
        switch cryptoCurrency {
        case .bitcoinCash:
            cryptoString = "BCH"
        case .bitcoin:
            cryptoString = "BTC"
        case .ethereum:
            cryptoString = "ETH"
        case .litecoin:
            cryptoString = "LTC"
            
        default:
            break
        }
        
        if self.text != nil && self.text! != "" {
            self.text = " " + cryptoString
        }
        else {
            self.text = cryptoString
        }
    }
}
