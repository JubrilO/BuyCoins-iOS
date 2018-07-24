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
import RSSelectionMenu

class SendCoinViewController: UIViewController, CardView, ValidationDelegate, QRCodeReaderViewControllerDelegate {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var availableBalanceLabel: UILabel!
    @IBOutlet weak var walletAddressTextField: BCBorderedTextField!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var amountView: BCAmountTextField!
    @IBOutlet weak var cardView: UIView!
    
    
    let validator = Validator()
    var backgroundView: UIView?
    let slideAnimator = CardPresentationAnimator()
    
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
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        amountView.cryptoNairaPrice = cryptoNairaPrice
        amountView.cryptocurrency = cryptocurrency
        amountView.selectCurrencyButton.addTarget(self, action: #selector(onselectCurrencyButtonTap), for: .touchUpInside)
        fetchAvailableBalance()
        setupTextFieldValidation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        cardView.isHidden = true
        backgroundView = view.resizableSnapshotView(from: view.bounds, afterScreenUpdates: true, withCapInsets: .zero)
        cardView.isHidden = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    @IBAction func onSendButtonTap(_ sender: UIButton) {
        validator.validate(self)
    }
    

    
    @IBAction func onMaxAmountButtonTap(_ sender: UIButton) {
        guard let walletData = walletData else {return}
        guard let availableBalance =  Double(walletData.currentUser!.wallet!.confirmedBalance!) else {return}
        //TO-DO add condition that accomodates for transaction fees
        
        
        if availableBalance > 0.0 {
           // amountTextField.text = String(availableBalance)
        }
    }
    
    @IBAction func onCloseButtonTap(_ sender: UIButton) {
        dismiss(animated: true)
    }

    @IBAction func onScanButtonTouch(_ sender: UIButton) {
        readerVC.delegate = self
        present(readerVC, animated: true)
    }
    
    @objc func onselectCurrencyButtonTap(sender: UIButton) {
        let data = ["BTC", "ETH", "LTC", "BCH"]
        let selectionMenu =  RSSelectionMenu(selectionType: .Single, dataSource: data, cellType: .Custom(nibName: "PopoverCell", cellIdentifier: "PopoverCell")) { (cell, object, indexPath) in
            let cell = cell as! PopoverCell
            cell.optionLabel.text = object
            cell.tintColor = UIColor.bcPurple
        }
        
        var selectedItemArray = [String.cryptocurrency(cryptocurrency)]
    
        selectionMenu.setSelectedItems(items: selectedItemArray) {
            text, isSelected, selectedItems in
            selectedItemArray = selectedItems
        }
        selectionMenu.show(style: .Popover(sourceView: sender, size: CGSize(width: 100, height: 180)), from: self)
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
        if Float(amountView.cryptoAmount) <= Float(walletData.currentUser!.wallet!.confirmedBalance!)! {
            print("actualcardheight: \(cardView.bounds.height)")
            view.endEditing(true)
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
        walletAddressTextField.text = address
        amountView.textField.placeholder = "0.00 " + String.cryptocurrency(cryptocurrency)
    }
    
    func setupTextFieldValidation() {
        validator.registerField(walletAddressTextField, rules: [RequiredRule()])
        validator.registerField(amountView.textField, rules: [RequiredRule(), FloatRule()])
    }
    
    func presentConfirmation() {
        let address = walletAddressTextField.text!
        let amount = amountView.cryptoAmount
        let networkFeeQuery = NetworkFeeQuery(amount: String(amount), address: TestCryptoAddress.address(cryptocurrency), cryptocurrency: cryptocurrency)
        ApolloManager.shared.apolloClient.fetch(query: networkFeeQuery, cachePolicy: .returnCacheDataAndFetch) {
            result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            guard let fee = result?.data?.getEstimatedNetworkFee?.estimatedFee else {return}
            let transferRequest = TransferRequest(walletAddress: address, amount: String(amount), cryptocurrency: self.cryptocurrency, otp: nil, cryptoNairaPrice: self.cryptoNairaPrice, fee: fee)
            if let confirmationVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIDs.ReviewSendScene) as? ReviewSendViewController {
                confirmationVC.transferRequest = transferRequest
                confirmationVC.transitioningDelegate = self
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

extension SendCoinViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if let destinationVC = presented as? ReviewSendViewController {
            slideAnimator.backgroundView = backgroundView
            slideAnimator.originCardView = cardView
            slideAnimator.destinationCardView = destinationVC.cardView
            return slideAnimator

        }
        else {
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let vc = dismissed as? ReviewSendViewController {
            let cardDismissalAnimator = CardDismissalAnimator()
            cardDismissalAnimator.originCardView = vc.cardView
            cardDismissalAnimator.destinationCardView = cardView
            cardDismissalAnimator.backgroundView = backgroundView
            return cardDismissalAnimator
        }
        return nil
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
