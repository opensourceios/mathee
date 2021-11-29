//
//  FormulaViewController.swift
//  Guess
//
//  Created by Daniel Springer on 01/07/2018.
//  Copyright © 2021 Daniel Springer. All rights reserved.
//

import UIKit


class FormulaViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var helperButton: UIButton!


    // MARK: Properties

    var total = 0
    var isFirstEvenQuestion = true
    var myTitle: String!
    var myThemeColor: UIColor!


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)
        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        myTextField.borderStyle = .roundedRect
        myTextField.keyboardType = .numberPad
        myTextField.delegate = self
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping

        start()
    }


    // Helpers

    func helpersShould(hide: Bool) {
        myTextField.isHidden = hide
        helperLabel.isHidden = hide
        helperButton.isHidden = hide
    }

    @objc func start() {
        total = 0
        isFirstEvenQuestion = true
        myTextField.text = ""
        messageLabel.text = NSLocalizedString("""
        Think of a number
        """, comment: "")

        let okButton = UIBarButtonItem(
            title: Const.Misc.okMessage,
            style: .plain,
            target: self,
            action: #selector(timesThree))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)

        helpersShould(hide: true)
    }


    @objc func timesThree() {
        messageLabel.text = NSLocalizedString("Multiply it by 3", comment: "")
        let okButton = UIBarButtonItem(
            title: Const.Misc.okMessage,
            style: .plain,
            target: self,
            action: #selector(oddOrEven))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func oddOrEven() {
        messageLabel.text = NSLocalizedString("Is the result odd or even?", comment: "")
        let oddButton = UIBarButtonItem(
            title: Const.Misc.oddMessage,
            style: .plain,
            target: self,
            action: #selector(addOne))
        let evenButton = UIBarButtonItem(
            title: Const.Misc.evenMessage,
            style: .plain,
            target: self,
            action: #selector(divideByTwo))


        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([oddButton, space, evenButton], animated: true)
    }


    @objc func addOne() {
        // tell user to add one
        messageLabel.text = NSLocalizedString("Add 1 to the result", comment: "")
        let okButton = UIBarButtonItem(
            title: Const.Misc.okMessage,
            style: .plain,
            target: self,
            action: #selector(divideByTwo))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)

        if isFirstEvenQuestion {
            total += 1
        } else {
            total += 2
        }
    }


    @objc func divideByTwo() {
        messageLabel.text = NSLocalizedString("Divide the result by 2", comment: "")
        var okButton = UIBarButtonItem()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        if isFirstEvenQuestion {
            okButton = UIBarButtonItem(
                title: Const.Misc.okMessage,
                style: .plain,
                target: self,
                action: #selector(timesThree))
            isFirstEvenQuestion = false
        } else {
            okButton = UIBarButtonItem(
                title: Const.Misc.okMessage,
                style: .plain,
                target: self,
                action: #selector(divideByNine))
        }

        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func divideByNine() {
        // tell user to divide by nine
        messageLabel.text = NSLocalizedString("Divide the result by 9, throwing away any remainder", comment: "")
        let okButton = UIBarButtonItem(
            title: Const.Misc.okMessage,
            style: .plain,
            target: self,
            action: #selector(askResult))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func askResult() {
        // ask current result to user
        myToolbar.setItems([], animated: true)

        messageLabel.text = "" // empty so user doesn't see disappearing text
        helpersShould(hide: false)
        myTextField.becomeFirstResponder()
    }


    @objc func checkResult() {

        guard let text = myTextField.text else {
            helpersShould(hide: true)

            messageLabel.text = NSLocalizedString(
            """
Something went wrong. Please let the developers know. Error #001
""", comment: "")
            let retryButton = UIBarButtonItem(
                title: Const.Misc.retryMessage,
                style: .plain,
                target: self,
                action: #selector(askResult))

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        guard !text.isEmpty else {
            helpersShould(hide: true)
            messageLabel.text = NSLocalizedString(
            """
TextField emtpy. Please enter your current result and try again
""", comment: "")
            let retryButton = UIBarButtonItem(
                title: Const.Misc.retryMessage,
                style: .plain,
                target: self,
                action: #selector(askResult))

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        let trimmedText = text.trimmingCharacters(in: .whitespaces)

        guard let number = Int(trimmedText),
              !number.multipliedReportingOverflow(by: 4).overflow else { // max allowed: 2305843009213693951
                  helpersShould(hide: true)
                  messageLabel.text = NSLocalizedString("""
            Please enter numbers only
            No text
            Max number: 2305843009213693951
            """, comment: "")
                  let retryButton = UIBarButtonItem(
                    title: Const.Misc.retryMessage,
                    style: .plain,
                    target: self,
                    action: #selector(askResult))

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
        messageLabel.text = NSLocalizedString("You thought:", comment: "") + "\n" + "\(total)" +
        "\n\n" + NSLocalizedString("Want to play again?", comment: "")

        let playAgainButton = UIBarButtonItem(
            title: Const.Misc.playAgainMessage,
            style: .plain,
            target: self,
            action: #selector(start))

        let doneButton = UIBarButtonItem(
            title: Const.Misc.endMessage,
            style: .done,
            target: self,
            action: #selector(doneButtonPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([playAgainButton, space, doneButton], animated: true)
    }


    @IBAction func okButtonKeyboardPressed() {
        myTextField.resignFirstResponder()
        checkResult()
    }


    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }


    // MARK: TableView

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        okButtonKeyboardPressed()
        return true
    }

}
