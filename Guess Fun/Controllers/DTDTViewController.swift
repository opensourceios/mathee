//
//  DTDTViewController.swift
//  Guess Fun
//
//  Created by Daniel Springer on 01/07/2018.
//  Copyright © 2018 Daniel Springer. All rights reserved.
//

import UIKit
import StoreKit


class DTDTViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var myTextField: UITextField!


    // MARK: Properties

    var total = 0
    var isFirstEvenQuestion = true


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor: view.tintColor
                ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor: view.tintColor
                ], for: .highlighted)

        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)


        myTextField.isHidden = true
        myTextField.borderStyle = .roundedRect
        myTextField.keyboardType = .numberPad

        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.text = "Think of a number.\nI will find it.\nLet me ask you a few questions..."

        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(timesThree))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        subscribeToKeyboardNotifications()
    }


    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }


    // Helpers

    @objc func timesThree() {
        // tell user to multiply by 3
        messageLabel.text = "Multiply it by 3"
        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(oddOrEven))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func oddOrEven() {
        // ask user if odd or even
        messageLabel.text = "Is the result odd or even?"
        let oddButton = UIBarButtonItem(title: "Odd", style: .plain, target: self, action: #selector(addOne))
        let evenButton = UIBarButtonItem(title: "Even", style: .plain, target: self, action: #selector(divideByTwo))

        oddButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
            NSAttributedString.Key.foregroundColor: view.tintColor],
                                         for: .normal)
        oddButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
            NSAttributedString.Key.foregroundColor: view.tintColor],
                                         for: .highlighted)
        evenButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
            NSAttributedString.Key.foregroundColor: view.tintColor],
                                          for: .normal)
        evenButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
            NSAttributedString.Key.foregroundColor: view.tintColor],
                                          for: .highlighted)

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([oddButton, space, evenButton], animated: true)
    }


    @objc func addOne() {
        // tell user to add one
        messageLabel.text = "Add 1 to the result"
        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(divideByTwo))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)

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
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        if isFirstEvenQuestion {
            okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(timesThree))
            isFirstEvenQuestion = false
        } else {
            okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(divideByNine))
        }

        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func divideByNine() {
        // tell user to divide by nine
        messageLabel.text = "Divide the result by 9, leaving out any remainder"
        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(askResult))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func askResult() {
        // ask current result to user
        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self,
                                       action: #selector(okButtonKeyboardPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)

        messageLabel.text = "" // empty so user doesn't see disappearing text
        myTextField.isHidden = false
        myTextField.becomeFirstResponder()
    }


    @objc func checkResult() {

        guard let text = myTextField.text else {
            myTextField.isHidden = true
            messageLabel.text = "Something went wrong. Please let the developers know. Error #001"
            let retryButton = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(askResult))
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor],
                                               for: .normal)
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor],
                                               for: .highlighted)

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        guard !text.isEmpty else {
            myTextField.isHidden = true
            messageLabel.text = "TextField emtpy. Please enter your current result and try again."
            let retryButton = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(askResult))
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor],
                                               for: .normal)
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor],
                                               for: .highlighted)

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        guard let number = Int(text) else {
            myTextField.isHidden = true
            messageLabel.text = "Please enter numbers only.\nNo text.\nMax number: 2^63 - 1."
            let retryButton = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(askResult))
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor],
                                               for: .normal)
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor],
                                               for: .highlighted)

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        total += number * 4

        showResult()

    }


    @objc func showResult() {
        // show final result to user
        myToolbar.setItems([], animated: true)
        myTextField.isHidden = true
        messageLabel.text = "You thought:\n\(total)"

        let doneButton = UIBarButtonItem(title: "🎉", style: .plain, target: self, action: #selector(doneButtonPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, doneButton, space], animated: true)
    }


    @objc func okButtonKeyboardPressed() {
        myTextField.resignFirstResponder()
        checkResult()
    }


    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
        SKStoreReviewController.requestReview()
    }


    // MARK: Subscription

    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }


    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    // MARK: Keyboard

    @objc func keyboardWillShow(_ notification: Notification) {
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }


    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }


    func getKeyboardHeight(_ notification: Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue // of CGRect
        return keyboardSize?.cgRectValue.height ?? CGFloat(0)
    }


}
