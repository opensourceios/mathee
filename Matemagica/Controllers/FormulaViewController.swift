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
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var helperButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    @IBOutlet weak var leftButton: UIButton!

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

        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(timesThree), for: .touchUpInside)
        rightButton.setTitle(Const.Misc.okMessage, for: .normal)
        leftButton.isHidden = true
        rightButton.sizeToFit()

        helpersShould(hide: true)
    }


    @objc func timesThree() {
        messageLabel.text = "Multiply it by 3"
        rightButton.setTitle(Const.Misc.okMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(oddOrEven), for: .touchUpInside)
        rightButton.sizeToFit()
    }


    @objc func oddOrEven() {
        messageLabel.text = "Is the result odd or even?"
        leftButton.isHidden = false
        leftButton.setTitle(Const.Misc.oddMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        leftButton.addTarget(self, action: #selector(addOne), for: .touchUpInside)
        rightButton.setTitle(Const.Misc.evenMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(divideByTwo), for: .touchUpInside)
        rightButton.sizeToFit()
        leftButton.sizeToFit()

    }


    @objc func addOne() {
        // tell user to add one
        messageLabel.text = "Add 1 to the result"
        leftButton.isHidden = true
        rightButton.setTitle(Const.Misc.okMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(divideByTwo), for: .touchUpInside)
        rightButton.sizeToFit()

        if isFirstEvenQuestion {
            total += 1
        } else {
            total += 2
        }
    }


    @objc func divideByTwo() {
        messageLabel.text = "Divide the result by 2"
        leftButton.isHidden = true
        if isFirstEvenQuestion {
            rightButton.setTitle(Const.Misc.okMessage, for: .normal)
            rightButton.removeTarget(nil, action: nil, for: .allEvents)
            rightButton.addTarget(self, action: #selector(timesThree), for: .touchUpInside)
            isFirstEvenQuestion = false
        } else {
            rightButton.setTitle(Const.Misc.okMessage, for: .normal)
            rightButton.removeTarget(nil, action: nil, for: .allEvents)
            rightButton.addTarget(self, action: #selector(divideByNine), for: .touchUpInside)
        }
        rightButton.sizeToFit()

    }


    @objc func divideByNine() {
        // tell user to divide by nine
        messageLabel.text = """
        Divide your result by 9, and type how many times 9 fits in it.
        Ignore leftover numbers. For example: if your result is 12, type 1 (ignoring the leftover 3)
        If your result is less than 9, type 0.
        """

        // ask current result to user
        helpersShould(hide: false)
        myTextField.becomeFirstResponder()
    }


    @objc func checkResult() {
        leftButton.isHidden = true
        guard let text = myTextField.text else {
            helpersShould(hide: true)

            messageLabel.text =
            """
            Something went wrong. Please let the developers know. Error #001
            """
            rightButton.setTitle(Const.Misc.retryMessage, for: .normal)
            rightButton.removeTarget(nil, action: nil, for: .allEvents)
            rightButton.addTarget(self, action: #selector(divideByNine), for: .touchUpInside)
            rightButton.sizeToFit()
            return
        }

        guard !text.isEmpty else {
            helpersShould(hide: true)
            messageLabel.text =
            """
            TextField emtpy. Please enter your current result and try again
            """
            rightButton.setTitle(Const.Misc.retryMessage, for: .normal)
            rightButton.removeTarget(nil, action: nil, for: .allEvents)
            rightButton.addTarget(self, action: #selector(divideByNine), for: .touchUpInside)
            rightButton.sizeToFit()
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
            rightButton.setTitle(Const.Misc.retryMessage, for: .normal)
            rightButton.removeTarget(nil, action: nil, for: .allEvents)
            rightButton.addTarget(self, action: #selector(divideByNine), for: .touchUpInside)
            rightButton.sizeToFit()
            return
        }


        total += number * 4
        showResult()
    }


    @objc func showResult() {
        helpersShould(hide: true)
        messageLabel.text = "You thought:" + "\n" + "\(total)"
        leftButton.isHidden = true
        rightButton.setTitle(Const.Misc.endMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        rightButton.sizeToFit()

    }


    @IBAction func okButtonKeyboardPressed() {
        myTextField.resignFirstResponder()
        checkResult()
    }


    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        okButtonKeyboardPressed()
        return true
    }

}