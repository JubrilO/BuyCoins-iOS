//
//  SignInViewController.swift
//  BuyCoins
//
//  Created by Jubril on 22/05/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class SignInViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var textFields = [SkyFloatingLabelTextField]()
    let validator = Validator()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldFonts()
        //setupTextFieldValidation()
    }
    
    @IBAction func onSignInButtonTap(_ sender: UIButton) {
        validator.validate(self)
        for state: UIControlState in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            sender.setAttributedTitle(NSAttributedString(string: ""), for: state)
            
        }
        addActivityIndicator()
    }
    
    func setupTextFieldValidation() {
        validator.registerField(emailTextField, rules: [RequiredRule(), EmailRule()])
        validator.registerField(passwordTextField, rules: [RequiredRule()])
    }
    
    func setupTextFieldFonts() {
        passwordTextField.isSecureTextEntry = true
        textFields = [emailTextField, passwordTextField]
        for field in textFields {
            field.titleFormatter = { $0.capitalized }
            field.titleFont = UIFont.textFieldTitleFont
            field.setTitleVisible(true)
        }
    }
    
    func addActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor).isActive = true
        cardView.layoutIfNeeded()
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        signInButton.setAttributedTitle(NSAttributedString(string: "Sign In"), for: .normal)
        signInButton.titleLabel?.textColor = UIColor.white
        signInButton.letterSpace = 0.5

    }

}

extension SignInViewController: ValidationDelegate {
    
    func validationSuccessful() {
        APIManager.sharedManager.signInUser(email: emailTextField.text!, password: passwordTextField.text!) {
            complete, error in
            if let error = error {
                //display error
                print("display error :\(error)")
                self.hideActivityIndicator()
                self.displayErrorModal(error: error.localizedDescription)
            }
            else {
                self.hideActivityIndicator()
                print("Signed in presenting home screen")
                self.displayErrorModal(error: error?.localizedDescription)
            }
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        hideActivityIndicator()
    }
}
