//
//  ViewController.swift
//  BuyCoins
//
//  Created by Jubril on 22/05/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class SignUpViewController: UIViewController, ValidationDelegate {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var dobTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    
    var textFields = [SkyFloatingLabelTextField]()
    let slideAnimator = CardPresentationAnimator()
    let validator = Validator()
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
    
    
    @IBAction func onContinueButtonTap(_ sender: UIButton) {
        validator.validate(self)
        
    }
    
    @IBAction func onSignInButtonTap() {
        dismiss(animated: true, completion: nil)
    }
    
    func validationSuccessful() {
        if let createAccountVC =  storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIDs.CreateAccountScene) as? CreateAccountViewController {
            let signUpRequest = SignUpRequest(firstname: firstNameTextField.text!, lastName: lastNameTextField.text!, dob: dobTextField.text!)
            createAccountVC.transitioningDelegate = self
            createAccountVC.signUpRequest = signUpRequest
            present(createAccountVC, animated: true, completion: nil)
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
    
    func setupTextFieldValidation() {
        validator.registerField(firstNameTextField, rules: [RequiredRule()])
        validator.registerField(lastNameTextField, rules: [RequiredRule()])
        validator.registerField(dobTextField, rules: [RequiredRule()])
    }
    
    func setupTextFieldFonts() {
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(onDatePickerValueChange), for: .valueChanged)
        datePicker.datePickerMode = .date
        dobTextField.inputView = datePicker
        textFields = [dobTextField, lastNameTextField, firstNameTextField]
        for field in textFields {
            field.titleFormatter = { $0.capitalized }
            field.titleFont = UIFont.textFieldTitleFont
            field.font = UIFont.bcFontRegular(size: 14)
            field.setTitleVisible(true)
        }
    }
    
    @objc func onDatePickerValueChange(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  =  "YYYY-MM-dd"
        let date =  sender.date
        dobTextField.text = dateFormatter.string(from: date)
    }
    
}

extension SignUpViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let vc = presented as? CreateAccountViewController {
            slideAnimator.backgroundView = backgroundView
            slideAnimator.originCardView = cardView
            slideAnimator.destinationCardView = vc.cardView
            return slideAnimator
        }
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let vc = dismissed as? CreateAccountViewController {
            let cardDismissalAnimator = CardDismissalAnimator()
            cardDismissalAnimator.originCardView = vc.cardView
            cardDismissalAnimator.destinationCardView = cardView
            cardDismissalAnimator.backgroundView = backgroundView
            return cardDismissalAnimator
        }
        return nil
    }
}

