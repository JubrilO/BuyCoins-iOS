//
//  SignInViewController.swift
//  BuyCoins
//
//  Created by Jubril on 22/05/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var textFields = [SkyFloatingLabelTextField]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldFonts()
    }
    
    func setupTextFieldFonts() {
        textFields = [emailTextField, passwordTextField]
        for field in textFields {
            field.titleFormatter = { $0.capitalized }
            field.titleFont = UIFont.textFieldTitleFont
        }
    }

}
