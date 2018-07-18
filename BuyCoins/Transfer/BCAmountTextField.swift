//
//  BCAmountTextField.swift
//  BuyCoins
//
//  Created by Jubril on 7/13/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//
import Foundation
import UIKit

class BCAmountTextField: UIView, UITextFieldDelegate {
    
    enum TextFieldValue {
        case crypto
        case naira
    }
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var selectCurrencyButton: UIButton!
    @IBOutlet weak var equivAmountLabel: UILabel!
    
    var cryptoAmount: Double = 0.0
    var nairaAmount: Double = 0.0
    var cryptoNairaPrice: Double?
    var cryptocurrency = Cryptocurrency.bitcoin
    
    var textFieldValue = TextFieldValue.crypto
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commontInit()
    }
    
    private func commontInit() {
        Bundle.main.loadNibNamed("BCAmountTextField", owner: self)
        addSubview(contentView)
        contentView.layer.cornerRadius = 5
        contentView.frame = bounds
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.coolGrey.withAlphaComponent(0.5).cgColor
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectCurrencyButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        selectCurrencyButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        selectCurrencyButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    
    @IBAction func onTapGestureRecognised(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func onSwitchButtonTap(_ sender: UIButton) {
        let amountValue = textField.text
        var equivValue = equivAmountLabel.text
        switch textFieldValue {
        case .crypto:
            textFieldValue = .naira
            textField.text = equivValue
            if amountValue! == "" {
                equivAmountLabel.text = "0.0"
            }
            else {
                equivAmountLabel.text = amountValue
            }
            currencyLabel.text = String.cryptocurrency(cryptocurrency)
            selectCurrencyButton.setTitle("NGN", for: .normal)
            selectCurrencyButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            selectCurrencyButton.setImage(UIImage(), for: .normal)
            
        case .naira:
            textFieldValue = .crypto
            selectCurrencyButton.setTitle(String.cryptocurrency(cryptocurrency), for: .normal)
            selectCurrencyButton.setImage(#imageLiteral(resourceName: "smallArrowDown"), for: .normal)
            selectCurrencyButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 0)
            selectCurrencyButton.isUserInteractionEnabled = true
            textField.text = amountValue
            currencyLabel.text = "NGN"
            equivAmountLabel.text = equivValue
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textFieldValue {
        case .crypto:
            if let pricePerUnit = cryptoNairaPrice, let amount = Double(textField.text! + string) {
                print("Crypto Naira Price: \(pricePerUnit) cryptoAmount: \(amount)")
                equivAmountLabel.text = (pricePerUnit * amount).withCommas()
            }
            cryptoAmount = Double(string) ??  0.0
            
        case .naira:
            if let pricePerUnit = cryptoNairaPrice, let amount = Double(textField.text! + string) {
                print("Crypto Naira Price: \(pricePerUnit) cryptoAmount: \(amount) Result: \(String((amount/pricePerUnit)))")

                equivAmountLabel.text =  String((amount/pricePerUnit).roundToPlaces(6))
                cryptoAmount = amount/pricePerUnit
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.bcPurple.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.coolGrey.withAlphaComponent(0.5).cgColor
    }
}
