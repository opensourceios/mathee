//
//  DTDTViewController.swift
//  Guess My Number Fun
//
//  Created by Dani Springer on 01/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import Foundation
import UIKit

class DTDTViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var myTextField: UITextField!
    
    // MARK: Properties
    
    var total = 0
    var isFirstEvenQuestion = true
    let storyboardID = "DTDTViewController"
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextField.isHidden = true
        myTextField.keyboardType = .numberPad
        let resignToolbar = UIToolbar()
        
        let okButtonKeyboard = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(okButtonKeyboardPressed))
        resignToolbar.items = [okButtonKeyboard]
        resignToolbar.sizeToFit()
        myTextField.inputAccessoryView = resignToolbar

        
        resultLabel.isHidden = true
        messageLabel.numberOfLines = 0
        messageLabel.text = "Think of a number"
        let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(timesThree))
        myToolbar.setItems([okButton], animated: true)
    }
    
    
    // Helpers
    
    @objc func timesThree() {
        // tell user to multiply by 3
        messageLabel.text = "Multiply it by 3"
        let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(oddOrEven))
        myToolbar.setItems([okButton], animated: true)
    }
    
    @objc func oddOrEven() {
        // ask user if odd or even
        messageLabel.text = "Is the result odd or even?"
        let oddButton = UIBarButtonItem(title: "Odd", style: .plain, target: self, action: #selector(addOne))
        let evenButton = UIBarButtonItem(title: "Even", style: .plain, target: self, action: #selector(divideByTwo))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([oddButton, space, evenButton], animated: true)
    }
    
    @objc func addOne() {
        // tell user to add one
        messageLabel.text = "Add 1 to the result"
        let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(divideByTwo))
        myToolbar.setItems([okButton], animated: true)
        
        if isFirstEvenQuestion {
            total += 1
        } else {
            total += 2
        }
    }
    
    @objc func divideByTwo() {
        // tell user to divide by two
        messageLabel.text = "Divide the result by 2"
        var okButton = UIBarButtonItem()
        
        if isFirstEvenQuestion {
            okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(timesThree))
            isFirstEvenQuestion = false
        } else {
            okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(divideByNine))
        }
        
        myToolbar.setItems([okButton], animated: true)
    }
    
    @objc func divideByNine() {
        // tell uesr to divide by nine
        messageLabel.text = "Divide the result by 9, leaving out any remainder"
        let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(askResult))
        myToolbar.setItems([okButton], animated: true)
    }
    
    @objc func askResult() {
        // ask current result to user
        messageLabel.text = "What is your current result?"
        myTextField.isHidden = false
        let submitButton = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(checkResult))
        myToolbar.setItems([submitButton], animated: true)
    }
    
    @objc func checkResult() {
        myTextField.isHidden = true
        guard let text = myTextField.text else {
            print("nil")
            messageLabel.text = "Something went wrong. Please let the developers know. Error #001"
            let retryButton = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(askResult))
            myToolbar.setItems([retryButton], animated: true)
            return
        }
        
        guard !text.isEmpty else {
            messageLabel.text = "TextField emtpy. Please enter your current result and try again."
            let retryButton = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(askResult))
            myToolbar.setItems([retryButton], animated: true)
            return
        }
        
        guard let number = Int(text) else {
            messageLabel.text = "Please enter numbers only. No text."
            let retryButton = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(askResult))
            myToolbar.setItems([retryButton], animated: true)
            return
        }
        
        total += number * 4
        
        showResult()
        
    }
    
    @objc func showResult() {
        // show final result to user
        resultLabel.isHidden = false
        messageLabel.text = "You thought:"
        resultLabel.text = "\(total)"
        
    }
    
    @objc func okButtonKeyboardPressed() {
        myTextField.resignFirstResponder()
    }
    
}
