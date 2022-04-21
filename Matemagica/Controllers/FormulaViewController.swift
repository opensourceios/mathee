//
//  FormulaViewController.swift
//  Matemagica
//
//  Created by Daniel Springer on 01/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


class FormulaViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var helperButton: UIButton!


    // MARK: Properties

    var total = 0
    var isFirstEvenQuestion = true
    var myTitle: String!
    let myThemeColor: UIColor = .systemPurple


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
        helperButton.isHidden = hide
    }

    @objc func start() {
        total = 0
        isFirstEvenQuestion = true
        myTextField.text = ""
        messageLabel.text = """
        Think of a number
        """

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
        messageLabel.text = "Multiply it by 3"
        let okButton = UIBarButtonItem(
            title: Const.Misc.okMessage,
            style: .plain,
            target: self,
            action: #selector(oddOrEven))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func oddOrEven() {
        messageLabel.text = "Is the result odd or even?"
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
        messageLabel.text = "Add 1 to the result"
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
        messageLabel.text = "Divide the result by 2"
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
        messageLabel.text = """
        Divide your result by 9, and type how many times 9 fits in it.
        Ignore leftover numbers. For example: if your result is 12, type 1 (ignoring the leftover 3)
        If your result is less than 9, type 0.
        """

        // ask current result to user
        myToolbar.setItems([], animated: true)
        helpersShould(hide: false)
        myTextField.becomeFirstResponder()
    }


    @objc func checkResult() {

        guard let text = myTextField.text else {
            helpersShould(hide: true)

            messageLabel.text =
            """
Something went wrong. Please let the developers know. Error #001
"""
            let retryButton = UIBarButtonItem(
                title: Const.Misc.retryMessage,
                style: .plain,
                target: self,
                action: #selector(divideByNine))

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        guard !text.isEmpty else {
            helpersShould(hide: true)
            messageLabel.text =
            """
TextField emtpy. Please enter your current result and try again
"""
            let retryButton = UIBarButtonItem(
                title: Const.Misc.retryMessage,
                style: .plain,
                target: self,
                action: #selector(divideByNine))

            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            myToolbar.setItems([space, retryButton], animated: true)
            return
        }

        let trimmedText = text.trimmingCharacters(in: .whitespaces)

        guard let number = Int(trimmedText),
              !number.multipliedReportingOverflow(by: 4).overflow else { // max allowed: 2305843009213693951
            helpersShould(hide: true)
            messageLabel.text = """
            Oops!
            That number is too big. Please think of a smaller number and try again
            (Please don't enter text. Only enter numbers)
            """
            // The highest number you can think of is: 2305843009213693951
            let retryButton = UIBarButtonItem(
                title: Const.Misc.retryMessage,
                style: .plain,
                target: self,
                action: #selector(divideByNine))

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
        messageLabel.text = "You thought:" + "\n" + "\(total)"

        let doneButton = UIBarButtonItem(
            title: Const.Misc.endMessage,
            style: .done,
            target: self,
            action: #selector(doneButtonPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, doneButton], animated: true)
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
