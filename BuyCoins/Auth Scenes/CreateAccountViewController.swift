//
//  CreateAccountViewController.swift
//  BuyCoins
//
//  Created by Jubril on 25/07/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class CreateAccountViewController: UIViewController, ValidationDelegate {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var signUpRequest: SignUpRequest!
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldFonts()
        setupTextFieldValidation()
    }
    
    @IBAction func onCreateAccountButtonTap(_ sender: UIButton) {
        validator.validate(self)
    }
    
    func setupTextFieldValidation() {
        validator.registerField(emailTextField, rules: [EmailRule()])
        validator.registerField(usernameTextField, rules: [RequiredRule()])
        validator.registerField(passwordTextField, rules: [PasswordRule()])
        validator.registerField(confirmPasswordTextField, rules: [ConfirmationRule(confirmField: passwordTextField)])
    }
    
    func setupTextFieldFonts() {
        let textFields: [SkyFloatingLabelTextField] = [emailTextField, usernameTextField, passwordTextField, confirmPasswordTextField]
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        for field in textFields {
            field.titleFormatter = { $0.capitalized }
            field.titleFont = UIFont.textFieldTitleFont
            field.font = UIFont.bcFontRegular(size: 14)
            field.setTitleVisible(true)
        }
    }
    
    func validationSuccessful() {
        
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors{
            if let field = field as? SkyFloatingLabelTextField {
                field.errorColor = UIColor.red
                field.errorMessage = error.errorMessage
            }
        }
    }
    
    
}
