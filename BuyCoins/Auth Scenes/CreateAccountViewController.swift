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
    let loadingVC = LoadingViewController()
    let slideInCardAnimator = CardPresentationAnimator()
    var backgroundView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldFonts()
        setupTextFieldValidation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cardView.isHidden = true
        backgroundView = view.resizableSnapshotView(from: view.bounds, afterScreenUpdates: true, withCapInsets: .zero)
        cardView.isHidden = false
    }
    
    @IBAction func onCreateAccountButtonTap(_ sender: UIButton) {
        add(loadingVC)
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
        APIManager.sharedManager.createUser(firsname: signUpRequest.firstname, lastname: signUpRequest.lastName, email: emailTextField.text!, password: passwordTextField.text!, username: usernameTextField.text!, dob: signUpRequest.dob) {
            user, error in
            self.loadingVC.remove()
            
            guard error != nil else {
                self.displayErrorModal(error: error?.localizedDescription)
                return
            }
            
            if let _ = user {
                self.presentEmailValidationScreen()
            }
            
        }
    }
    
    func presentEmailValidationScreen() {
        if let verifyEmailVC = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIDs.verifyEmailScene) as? VerifyViewController {
            verifyEmailVC.transitioningDelegate = self
            present(verifyEmailVC, animated: true)
        }
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

extension CreateAccountViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let vc = presented as? VerifyViewController {
            slideInCardAnimator.backgroundView = backgroundView
            slideInCardAnimator.originCardView = cardView
            slideInCardAnimator.destinationCardView = vc.cardView
            return slideInCardAnimator
        }
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
