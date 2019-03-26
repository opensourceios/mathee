//
//  DTDTViewController.swift
//  Guess
//
//  Created by Daniel Springer on 01/07/2018.
//  Copyright © 2019 Daniel Springer. All rights reserved.
//

import UIKit
import StoreKit


class DTDTViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var helperButton: UIButton!


    // MARK: Properties

    var total = 0
    var isFirstEvenQuestion = true


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor: view.tintColor as Any
                ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor: view.tintColor as Any
                ], for: .highlighted)

        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        myTextField.borderStyle = .roundedRect
        myTextField.keyboardType = .numberPad

        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.text = "Think of a number.\nI will find it.\nLet me ask you a few questions..."

        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(timesThree))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)

        helpersShould(hide: true)

        let darkMode = UserDefaults.standard.bool(forKey: Constants.UserDef.darkModeEnabled)

        view.backgroundColor = darkMode ? .black : .white
        messageLabel.textColor = darkMode ? .white : .black
        myTextField.backgroundColor = darkMode ? .black : .white
        myTextField.textColor = darkMode ? .white : .black
        myTextField.tintColor = darkMode ? .white : .black
        let placeholderColor: UIColor = darkMode ? .white : .black
        myTextField.attributedPlaceholder = NSAttributedString(
            string: "Type here",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        helperLabel.textColor = darkMode ? .white : .black

    }


    // Helpers

    func helpersShould(hide: Bool) {
        myTextField.isHidden = hide
        helperLabel.isHidden = hide
        helperButton.isHidden = hide
    }


    @objc func timesThree() {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
        messageLabel.text = "Multiply it by 3"
        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(oddOrEven))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func oddOrEven() {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
        messageLabel.text = "Is the result odd or even?"
        let oddButton = UIBarButtonItem(title: "Odd", style: .plain, target: self, action: #selector(addOne))
        let evenButton = UIBarButtonItem(title: "Even", style: .plain, target: self, action: #selector(divideByTwo))

        oddButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
            NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                         for: .normal)
        oddButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
            NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                         for: .highlighted)
        evenButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
            NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                          for: .normal)
        evenButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
            NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                          for: .highlighted)

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([oddButton, space, evenButton], animated: true)
    }


    @objc func addOne() {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.low)
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
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
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
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
        // tell user to divide by nine
        messageLabel.text = "Divide the result by 9, leaving out any remainder"
        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(askResult))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func askResult() {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
        // ask current result to user
        myToolbar.setItems([], animated: true)

        messageLabel.text = "" // empty so user doesn't see disappearing text
        helpersShould(hide: false)
        myTextField.becomeFirstResponder()
    }


    @objc func checkResult() {

        guard let text = myTextField.text else {
            helpersShould(hide: true)

            messageLabel.text = "Something went wrong. Please let the developers know. Error #001"
            let retryButton = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(askResult))
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                               for: .normal)
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                               for: .highlighted)

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        guard !text.isEmpty else {
            helpersShould(hide: true)
            messageLabel.text = "TextField emtpy. Please enter your current result and try again."
            let retryButton = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(askResult))
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                               for: .normal)
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                               for: .highlighted)

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        guard let number = Int(text) else {
            helpersShould(hide: true)
            messageLabel.text = "Please enter numbers only.\nNo text.\nMax number: 2^63 - 1."
            let retryButton = UIBarButtonItem(title: "Retry", style: .plain, target: self, action: #selector(askResult))
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                               for: .normal)
            retryButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 40.0)!,
                NSAttributedString.Key.foregroundColor: view.tintColor as Any],
                                               for: .highlighted)

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        total += number * 4

        showResult()

    }


    @objc func showResult() {
        myToolbar.setItems([], animated: true)
        helpersShould(hide: true)
        messageLabel.text = "You thought:\n\(total)"
        AppData.getSoundEnabledSettings(sound: Constants.Sound.chime)

        let doneButton = UIBarButtonItem(title: "🎉", style: .plain, target: self, action: #selector(doneButtonPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, doneButton, space], animated: true)
    }


    @IBAction func okButtonKeyboardPressed() {
        myTextField.resignFirstResponder()
        checkResult()
    }


    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
        SKStoreReviewController.requestReview()
    }


}
