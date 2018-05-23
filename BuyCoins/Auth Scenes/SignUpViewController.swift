//
//  ViewController.swift
//  BuyCoins
//
//  Created by Jubril on 22/05/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignUpViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var dobTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    
    var textFields = [SkyFloatingLabelTextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldFonts()
    }
    
    @IBAction func onContinueButtonTap(_ sender: UIButton) {
        
    }
    
    @IBAction func onSignInButtonTap() {
        
    }
    
    func setupTextFieldFonts() {
        textFields = [emailTextField, passwordTextField, confirmPasswordTextField, usernameTextField, emailTextField, dobTextField, lastNameTextField, firstNameTextField]
        for field in textFields {
            field.titleFormatter = { $0.capitalized }
            field.titleFont = UIFont.textFieldTitleFont
        }
    }

}

